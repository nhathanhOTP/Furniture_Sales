package com.nhathanh.entity;

import java.util.Date;
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
@Table(name = "Favourites")
public class Favourite {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "username")
	Account account;
	
	@ManyToOne
	@JoinColumn(name = "idproduct")
	Product product;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date datecreate = new Date();

}
