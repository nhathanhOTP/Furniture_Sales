package com.nhathanh.entity;

import java.io.Serializable;
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

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@SuppressWarnings("serial")
@Data
@Entity
@Table(name = "thetimeused")
public class TheTimeUsed implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name="numberofuse")
	private int NumberOfUse;
	@Column(name="amountdiscount")
	private Double AmountDiscount;
	
	
	@ManyToOne
	@JoinColumn(name = "iddiscount")
	Discount discount;
	
	@ManyToOne
	@JoinColumn(name = "username")
	Account account;
}
