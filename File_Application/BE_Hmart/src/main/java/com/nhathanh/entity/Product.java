package com.nhathanh.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity @Table(name = "Products")
public class Product  implements Serializable{
	@Id	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String name;
	private String image;
	private Double price;
	@Temporal(TemporalType.DATE)
	@Column(name = "createdate")
	private Date createDate = new Date();
	private Boolean available;
	@Column(name = "guarentee")
	private String guarentee;
	@Column(name="madeof")
	private String madeOf;
	@Column(name="color")
	private String color;
	@Column(name="size")
	private String size;
	
	@ManyToOne
	@JoinColumn(name = "Categoryid")
	Category category;
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<OrderDetail> orderDetails;	
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<Discount> discounts;	
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<Evaluate> evaluates;
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<Favourite> favourites;	
}
