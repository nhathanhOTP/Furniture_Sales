package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;

@CrossOrigin("*")
@RestController
public class ProductRestController {

	@Autowired
	ProductDAO productDao;
	
	@GetMapping("/hfn/product/getAll")
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
	
	@GetMapping("/hfn/item/{id}")
	public Item getItem(@PathVariable("id") Integer id) {
		Item item = new Item();
		BeanUtils.copyProperties(productDao.findById(id).get(), item);
		return item;
	}

}
