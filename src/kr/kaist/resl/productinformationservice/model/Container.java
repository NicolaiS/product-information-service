package kr.kaist.resl.productinformationservice.model;

import java.util.List;

/**
 * 
 * @author NicolaiSonne
 *
 *         Response model of Attribute Container
 */
public class Container {

	private String name = null;
	private Integer sortOrder = null;
	private List<Attribute> attributes = null;

	public Container(String name, Integer sortOrder, List<Attribute> attributes) {
		super();
		this.name = name;
		this.sortOrder = sortOrder;
		this.attributes = attributes;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public List<Attribute> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

}
