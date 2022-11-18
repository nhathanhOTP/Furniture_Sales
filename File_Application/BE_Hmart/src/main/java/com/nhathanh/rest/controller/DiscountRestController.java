package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.DiscountDAO;
import com.nhathanh.entity.Discount;

@CrossOrigin("*")
@RestController
public class DiscountRestController {
	@Autowired
	DiscountDAO disDAO;

	@GetMapping("/getAll/discount")
	public List<Discount> getAll() {
		return disDAO.findAll();
	}
	
	@PostMapping("/create/new_discount")
	public Discount create(@RequestBody Discount con) {
		return disDAO.save(con);
	}

	@PostMapping("/update/discount")
	public Discount update(@RequestBody Discount con) {
		return disDAO.save(con);
	}

	@DeleteMapping("/delete/discount/{id}")
	public void delete(@PathVariable("id") Integer id) {
		System.out.println(id);
		disDAO.delete(disDAO.findById(id).get());
	}
}
