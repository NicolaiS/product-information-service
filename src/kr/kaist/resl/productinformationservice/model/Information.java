package kr.kaist.resl.productinformationservice.model;

import java.util.ArrayList;
import java.util.List;

import kr.kaist.resl.productinformationservice.EnumStatusMsg;

/**
 * 
 * @author NicolaiSonne
 *
 *         Response model of Information
 */
public class Information {

	private String urn = null;
	private String message = null;
	private Integer version = null;
	private List<Attribute> attributes = null;
	private List<Container> containers = null;

	public Information(String urn, String message, Integer version) {
		this.urn = urn;
		this.message = message;
		this.version = version;
		if (EnumStatusMsg.OK.getName().equals(message)) {
			this.attributes = new ArrayList<Attribute>();
			this.containers = new ArrayList<Container>();
		}
	}

	public String getUrn() {
		return urn;
	}

	public void setUrn(String urn) {
		this.urn = urn;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	public List<Container> getContainers() {
		return containers;
	}

	public void setContainers(List<Container> containers) {
		this.containers = containers;
	}

}
