package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.CategoryDAO;
import com.nhathanh.entity.Category;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
public class ProductRestController {
	@Autowired
	CategoryDAO cteDao;

	@GetMapping("/getAll/categories")
	public List<Category> categories() {
		return cteDao.findAll();
	}
}
