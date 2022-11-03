package com.nhathanh.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity
@Table(name = "Discount")
public class Discount {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "iddiscount")
	int idDiscount;
	@Column(name = "valuediscount")
	private Float valuediscount;
	@Column(name = "titlediscount")
	private String TitleDiscount;
	@Column(name = "contentdiscount")
	private String ContentDiscount;
	@Column(name = "startdate")
	private Date StartDate;
	@Column(name = "enddate")
	private Date EndDate;
	
	@ManyToOne
	@JoinColumn(name = "IdProducts")
	Product product;
	@ManyToOne
	@JoinColumn(name = "ConditionsOfUse")
	Condition conditions;
}
