package com.nhathanh.rest.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;

@CrossOrigin("*")
@RestController
public class AccountRestController {
	@Autowired
	AccountDAO accountDao;

	@GetMapping("/hfn/Account/getAll")
	public List<Account> getAll(){
		return accountDao.findAll();
	}
	
	@GetMapping("/hfn/Account/{username}")
	public Account getOne(@PathVariable("username") String username) {
		return accountDao.findById(username).get();
	}
}
