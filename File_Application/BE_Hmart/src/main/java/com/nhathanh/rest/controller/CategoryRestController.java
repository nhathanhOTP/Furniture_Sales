package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.CategoryDAO;
import com.nhathanh.entity.Category;

@CrossOrigin("*")
@RestController
public class CategoryRestController {
	@Autowired
	CategoryDAO cateDAO;

	@GetMapping("/hfn/categories/getAll")
	public List<Category> categories() {
		return cateDAO.findAll();
	}
	
	@GetMapping("/check/file")
	public List<Category> check() {
		return cateDAO.findAll();
	}
}
