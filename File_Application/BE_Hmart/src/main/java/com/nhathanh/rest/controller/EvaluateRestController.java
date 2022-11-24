package com.nhathanh.rest.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;

@CrossOrigin("*")
@RestController
public class EvaluateRestController {
	
	@Autowired
	ProductDAO productDao;
	
	@Autowired
	FavouriteDAO favourDao;
	
	@Autowired
	AccountDAO accDao;
	
	@Autowired
	EvaluateDAO evaDao;
	
	@GetMapping("/hfn/evaluate/getAll")
	public List<Evaluate> getAll(){
		return evaDao.findAll();
	}
	
	@GetMapping("/hfn/evaluate/getOne/{id}")
	public Evaluate getOne(@PathVariable("id") Integer id){
		return evaDao.findById(id).get();
	}
	
	@GetMapping("/hfn/evaluate/getByPr/{id}")
	public List<Evaluate> getByPr(@PathVariable("id") Integer id){
		
		List<Evaluate> ds = evaDao.findByProductId(id);
		for (int i = 0; i < ds.size(); i++) {
			if (ds.get(i).getStatusEva() == false) {
				ds.remove(i);
			}
		}
		
		return ds;
	}
	
	@PostMapping("/hfn/evaluate/add")
	public Evaluate add(@RequestBody Evaluate fav){
		fav.setAccount(accDao.findById(fav.getAccount().getUsername()).get());
		fav.setProduct(productDao.findById(fav.getProduct().getId()).get());
		Date date = new Date();
		fav.setCreateDate(date);
		fav.setStatusEva(false);
		evaDao.save(fav);
		return fav;
	}
	
	@GetMapping("/hfn/evaluate/checkUser/{username}/{id}")
	public Integer checkUser(@PathVariable("username") String username, @PathVariable("id") Integer id){
		return accDao.checkUserOrdered(username, id);
	}
	
}
