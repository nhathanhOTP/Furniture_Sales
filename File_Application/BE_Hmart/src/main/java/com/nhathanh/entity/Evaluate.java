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
	@Column(name = "images")
	private String Images;
	
	@ManyToOne
	@JoinColumn(name = "IdProduct")
	Product product;
}
