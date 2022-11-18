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

import com.nhathanh.dao.ConditionsDAO;
import com.nhathanh.entity.Condition;

@CrossOrigin("*")
@RestController
public class ConditionsRestController {
	@Autowired
	ConditionsDAO conDao;

	@GetMapping("/getAll/conditent")
	public List<Condition> getAll() {
		return conDao.findAll();
	}

	@PostMapping("/create/new_condition")
	public Condition create(@RequestBody Condition con) {
		return conDao.save(con);
	}

	@PostMapping("/update/condition")
	public Condition update(@RequestBody Condition con) {
		return conDao.save(con);
	}

	@DeleteMapping("/delete/condition/{id}")
	public void delete(@PathVariable("id") Integer id) {
		System.out.println(id);
		conDao.delete(conDao.findById(id).get());
	}
}
