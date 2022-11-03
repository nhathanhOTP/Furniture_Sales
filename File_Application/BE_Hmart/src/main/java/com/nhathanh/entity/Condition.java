package com.nhathanh.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
@SuppressWarnings("serial")
@Data
@Entity
@Table(name = "Conditions")
public class Condition {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idconditions")
	private int id;
	@Column(name = "minspend")
	private String contents;
	@Column(name="quantityrequest")
	private int quantity;
	
	@JsonIgnore
	@OneToMany(mappedBy = "conditions")
	List<Discount> discount;
	
}
