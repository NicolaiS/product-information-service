package kr.kaist.resl.productinformationservice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import kr.kaist.resl.productinformationservice.model.Attribute;
import kr.kaist.resl.productinformationservice.model.Container;
import kr.kaist.resl.productinformationservice.model.Information;
import kr.kaist.resl.productinformationservice.model.Result;
import kr.kaist.resl.productinformationservice.model.UrnBatch;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 
 * @author NicolaiSonne
 *
 *         Handles product information queries
 */
@Path("/query")
public class Query {

	@GET
	@Produces(MediaType.TEXT_HTML)
	public String getProductDataHTML(@QueryParam("urn") String urn,
			@DefaultValue("-1") @QueryParam("cVersion") int companyVersion,
			@DefaultValue("-1") @QueryParam("iVersion") int itemVersion,
			@DefaultValue("-1") @QueryParam("bVersion") int batchVersion,
			@DefaultValue("-1") @QueryParam("uVersion") int uniqueVersion)
			throws Exception {
		return getProductDataJSON(urn, companyVersion, itemVersion,
				batchVersion, uniqueVersion);
	}

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String getProductDataJSON(@QueryParam("urn") String urn,
			@DefaultValue("-1") @QueryParam("cVersion") int companyVersion,
			@DefaultValue("-1") @QueryParam("iVersion") int itemVersion,
			@DefaultValue("-1") @QueryParam("bVersion") int batchVersion,
			@DefaultValue("-1") @QueryParam("uVersion") int uniqueVersion)
			throws Exception {

		System.out.println("- Received Product Information request");

		Gson gson = new GsonBuilder().setPrettyPrinting().create();

		Result result = new Result();

		System.out.println("-- URN: " + urn);
		if (companyVersion >= 0)
			System.out.println("-- cVersion: " + companyVersion);
		if (itemVersion >= 0)
			System.out.println("-- iVersion: " + itemVersion);
		if (batchVersion >= 0)
			System.out.println("-- bVersion: " + batchVersion);
		if (uniqueVersion >= 0)
			System.out.println("-- uVersion: " + uniqueVersion);

		if (urn == null) {
			System.out.println("- Returning empty Result");
			return gson.toJson(result);
		}

		// Initialize data connection
		Connection conn = null;
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/product_information");
		conn = ds.getConnection();

		// Generate URNs
		UrnBatch urnBatch = generateUrnBatch(urn, conn);

		// Get information
		result.setCompanyInformation(getInformation(conn,
				urnBatch.getCompanyURN(), companyVersion));
		result.setItemInformation(getInformation(conn, urnBatch.getItemURN(),
				itemVersion));
		result.setBatchInformation(getInformation(conn, urnBatch.getBatchURN(),
				batchVersion));
		result.setUniqueInformation(getInformation(conn,
				urnBatch.getUniqueURN(), uniqueVersion));

		if (conn != null)
			conn.close();

		System.out.println("-- Returning result");

		return gson.toJson(result);
	}

	private String preSGTIN = "urn:epc:class:sgtin:";
	private String preLGTIN = "urn:epc:class:lgtin:";

	/**
	 * Generates URNs
	 * 
	 * @param urn
	 * @param conn
	 * @return URN batch
	 * @throws Exception
	 */
	private UrnBatch generateUrnBatch(String urn, Connection conn)
			throws Exception {
		UrnBatch batch = new UrnBatch();

		String[] initSplit = urn.split(":");
		String sgtin = initSplit[initSplit.length - 1];
		String[] split = sgtin.split("\\.");

		// Generate URNs
		if (!split[0].equals("*"))
			batch.setCompanyURN(preSGTIN + split[0] + ".*.*");
		if (!split[0].equals("*") && !split[1].equals("*"))
			batch.setItemURN(preSGTIN + split[0] + "." + split[1] + ".*");
		if (!split[0].equals("*") && !split[1].equals("*")
				&& !split[2].equals("*"))
			batch.setUniqueURN(preSGTIN + split[0] + "." + split[1] + "."
					+ split[2]);

		// Get Batch number
		PreparedStatement ps = null;
		ResultSet rs = null;
		String selectSQL = "SELECT attr_value FROM attribute INNER JOIN urn ON urn.urn_id=attribute.urn_id WHERE attribute.attr_key = 'attr_batch_no' AND urn = ?";

		ps = conn.prepareStatement(selectSQL);
		ps.setString(1, urn);

		rs = ps.executeQuery();

		if (rs.next() && !split[0].equals("*") && !split[1].equals("*")) {
			batch.setBatchURN(preLGTIN + split[0] + "." + split[1] + "."
					+ rs.getString("attr_value"));
		}

		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();

		System.out.println("- Generating URNs");
		System.out.println("-- cURN: " + batch.getCompanyURN());
		System.out.println("-- iURN: " + batch.getItemURN());
		System.out.println("-- bURN: " + batch.getBatchURN());
		System.out.println("-- uURN: " + batch.getUniqueURN());

		return batch;
	}

	/**
	 * Get information of URN
	 * 
	 * @param conn
	 *            DB Conn
	 * @param urn
	 *            URN
	 * @param version
	 *            Held version
	 * @return URN information
	 * @throws SQLException
	 */
	private Information getInformation(Connection conn, String urn, int version)
			throws SQLException {
		int urnId;
		Information info = null;

		System.out.println("- Getting info for: " + urn);

		String selectSQL = "SELECT * FROM urn WHERE urn = ?";

		PreparedStatement ps = conn.prepareStatement(selectSQL);
		ps.setString(1, urn);
		ResultSet rs = ps.executeQuery();

		if (!rs.next()) {
			System.out.println("-- URN not found");
			info = new Information(urn, EnumStatusMsg.NOT_FOUND.getName(), null);
			return info;
		}

		int currentVersion = rs.getInt("urn_version");
		if (version >= currentVersion) {
			System.out.println("-- Info up-to-date");
			info = new Information(urn, EnumStatusMsg.UP_TO_DATE.getName(),
					null);
			return info;
		}

		urnId = rs.getInt("urn_id");
		info = new Information(urn, EnumStatusMsg.OK.getName(), currentVersion);
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();

		info.setAttributes(getAttributes(conn, urnId));
		info.setContainers(getContainers(conn, urnId));

		System.out.println("-- Found " + info.getAttributes().size()
				+ " attributes and " + info.getContainers().size()
				+ " containers");

		return info;
	}

	/**
	 * Get attributes for URN
	 * 
	 * @param conn
	 * @param urnId
	 *            Primary key of URN
	 * @return List of attributes
	 * @throws SQLException
	 */
	private List<Attribute> getAttributes(Connection conn, Integer urnId)
			throws SQLException {
		List<Attribute> result = new ArrayList<Attribute>();

		String selectSQL = "SELECT * FROM attribute WHERE urn_id = ? ORDER BY sort_order";
		PreparedStatement ps = conn.prepareStatement(selectSQL);

		ps.setInt(1, urnId);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			int attrTypeId = rs.getInt("attr_type_id");
			String attrKey = rs.getString("attr_key");
			String attrName = rs.getString("attr_name");
			String attrValue = rs.getString("attr_value");
			String valueFormat = rs.getString("value_format");
			int sortOrder = rs.getInt("sort_order");
			Attribute attr = new Attribute(attrTypeId, attrKey, attrName,
					attrValue, valueFormat, sortOrder);
			result.add(attr);
		}
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();

		return result;
	}

	/**
	 * Get attribute containers of URN
	 * 
	 * @param conn
	 *            DB conn
	 * @param urnId
	 *            Primary key of URN
	 * @return List of attribute containers
	 * @throws SQLException
	 */
	private List<Container> getContainers(Connection conn, Integer urnId)
			throws SQLException {
		String selectSQL = "SELECT * FROM container WHERE urn_id = ? ORDER BY sort_order";
		PreparedStatement ps = conn.prepareStatement(selectSQL);

		ps.setInt(1, urnId);
		ResultSet rs = ps.executeQuery();

		List<Container> containers = new ArrayList<Container>();
		while (rs.next()) {
			int containerId = rs.getInt("container_id");
			String name = rs.getString("name");
			int sortOrder = rs.getInt("sort_order");
			List<Attribute> conAttr = getContainerAttributes(conn, containerId);
			Container c = new Container(name, sortOrder, conAttr);
			containers.add(c);
		}
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();

		return containers;
	}

	/**
	 * Get attributes of container
	 * 
	 * @param conn
	 *            DB Conn
	 * @param containerId
	 *            Primary key of container
	 * @return List of attributes
	 * @throws SQLException
	 */
	private List<Attribute> getContainerAttributes(Connection conn,
			Integer containerId) throws SQLException {
		List<Attribute> result = new ArrayList<Attribute>();

		String selectSQL = "SELECT * FROM container_attr WHERE container_id = ? ORDER BY sort_order";
		PreparedStatement ps = conn.prepareStatement(selectSQL);

		ps.setInt(1, containerId);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			int attrTypeId = rs.getInt("attr_type_id");
			String attrKey = rs.getString("attr_key");
			String attrName = rs.getString("attr_name");
			String attrValue = rs.getString("attr_value");
			String valueFormat = rs.getString("value_format");
			int sortOrder = rs.getInt("sort_order");
			Attribute attr = new Attribute(attrTypeId, attrKey, attrName,
					attrValue, valueFormat, sortOrder);
			result.add(attr);
		}
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();

		return result;
	}
}
