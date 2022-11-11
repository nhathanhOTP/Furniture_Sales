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
	Integer id;
	String name;
	String image;
	Double price;
	@Temporal(TemporalType.DATE)
<<<<<<< HEAD
	@Column(name = "Createdate")
	Date createDate = new Date();
	Boolean available;
=======
	@Column(name = "createdate")
	private Date createDate = new Date();
	private Boolean available;
<<<<<<<<< Temporary merge branch 1
=========
	@Column(name = "origin")
>>>>>>>>> Temporary merge branch 2
	private String origin;
	@Column(name = "guarentee")
	private String guarentee;
	@Column(name="madeof")
	private String madeOf;
	@Column(name="color")
	private String color;
	@Column(name="size")
	private String size;
>>>>>>> Main_merge
	
	@ManyToOne
	@JoinColumn(name = "Categoryid")
	Category category;
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<OrderDetail> orderDetails;	
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<Discount> discount;	
	
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<Evaluate> evaluate;
	
}
