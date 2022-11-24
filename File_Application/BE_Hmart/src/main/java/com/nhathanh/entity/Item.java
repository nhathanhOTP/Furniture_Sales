package com.nhathanh.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Item {
	private int id;
	private String name;
	private double price;
	private String image;
	private int quantity;
	private int productQty;
}
