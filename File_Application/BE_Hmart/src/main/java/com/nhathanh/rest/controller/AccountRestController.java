package com.nhathanh.rest.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.AccountDAO;
import com.nhathanh.entity.Account;
import com.nhathanh.entity.Role;

@CrossOrigin("*")
@RestController
public class AccountRestController {
	@Autowired
	AccountDAO accountDao;

	@GetMapping("/hfn/Account/getAll")
	public List<Account> getAll() {
		return accountDao.findAll();
	}

	@GetMapping("/hfn/Account/{username}")
	public Account getOne(@PathVariable("username") String username) {
		try {
			return accountDao.findById(username).get();
		} catch (Exception e) {
			return null;
		}

	}

	@PostMapping("/bangphi/createUser")
	public Account createUser(@RequestBody Account entity) {
		Role role = new Role();
		role.setId("CUS");
		entity.setRole(role);
		entity.setPhoto("a.jpg");
		Account ac = accountDao.save(entity);
		System.out.println(ac.getUsername());
		return ac;
	}

}
