package com.nhathanh.rest.controller;

public class CategoryRestController {

<<<<<<< HEAD
=======
	@GetMapping("/hfn/categories/getAll")
	public List<Category> categories() {
		return cateDAO.findAll();
	}
	
	@GetMapping("/check/file")
	public List<Category> check() {
		return cateDAO.findAll();
	}
>>>>>>> Main_merge
}
