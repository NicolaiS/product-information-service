package kr.kaist.resl.productinformationservice.model;

/**
 * Created by nicolais on 5/22/15.
 * 
 * Holds URNs 
 */
public class UrnBatch {

	private String companyURN = null;
	private String itemURN = null;
	private String uniqueURN = null;
	private String batchURN = null;

	public UrnBatch() {
	}

	public String getCompanyURN() {
		return companyURN;
	}

	public void setCompanyURN(String companyURN) {
		this.companyURN = companyURN;
	}

	public String getItemURN() {
		return itemURN;
	}

	public void setItemURN(String itemURN) {
		this.itemURN = itemURN;
	}

	public String getUniqueURN() {
		return uniqueURN;
	}

	public void setUniqueURN(String uniqueURN) {
		this.uniqueURN = uniqueURN;
	}

	public String getBatchURN() {
		return batchURN;
	}

	public void setBatchURN(String batchURN) {
		this.batchURN = batchURN;
	}

}
