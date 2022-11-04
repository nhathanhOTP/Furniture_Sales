package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.*;
import com.nhathanh.entity.Product;

@RestController
@CrossOrigin("*")
public class ProductRestController {
	@Autowired
	ProductDAO productDao;
	
	@GetMapping("/hfn/product/all")
	public List<Product> getAll(){
		return productDao.findAll();
	}
	
	@GetMapping("/hfn/product/{id}")
	public Product getOne(@PathVariable("id") Integer id) {
		return productDao.findById(id).get();
	}
	
	@GetMapping("/hfn/product/cate/{id}")
	public List<Product> getByCate(@PathVariable("id") String id) {
		return productDao.findByCategoryId(id);
	}
}
