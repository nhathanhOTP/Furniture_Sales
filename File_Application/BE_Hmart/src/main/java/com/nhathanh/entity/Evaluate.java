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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity
@Table(name = "Evaluate")
public class Evaluate {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idevaluate")
	private String idEvaluate;
	
	@Column(name = "contents")
	private String Contents;
	
	@Column(name = "numberstart")
	private int NumberStart;
	
	@Column(name = "statuseva")
	private Boolean statusEva;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "createdate")
	Date createDate = new Date();
	
	@ManyToOne
	@JoinColumn(name = "idproduct")
	Product product;
	
	@ManyToOne
	@JoinColumn(name = "username")
	Account account;
}
