package com.nhathanh.rest.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.nhathanh.dao.AccountDAO;
import com.nhathanh.dao.TheTimeDAO;
import com.nhathanh.entity.Account;
import com.nhathanh.entity.TheTimeUsed;

@CrossOrigin("*")
@RestController
public class TheTimeRestController {
	// By NhaThanh
	@Autowired
	TheTimeDAO theTimeDao;
	@Autowired
	AccountDAO acDao;

	@GetMapping("/theTime/getAll")
	public List<TheTimeUsed> getAll() {
		return theTimeDao.findAll();
	}

	@GetMapping("/theTime/{id}")
	public TheTimeUsed getOne(@PathVariable("id") Integer id) {
		return theTimeDao.findById(id).get();
	}

	@PostMapping("/create/theTime")
	public TheTimeUsed create(@RequestBody TheTimeUsed theTime) {
		// ------------------------------------------------------//
		try {
			String username = theTime.getAccount().getUsername();
			int idDiscount = theTime.getDiscount().getIdDiscount();
			TheTimeUsed newTheTime = theTimeDao.sp_findByUsernameAndDiscount(username, idDiscount);
			newTheTime.setNumberOfUse(newTheTime.getNumberOfUse()+1);	
			return theTimeDao.save(newTheTime);
		} catch (Exception e) {
			// Create new condition for user this next time
			theTime.setNumberOfUse(1);
			System.out.println(theTime);
			return theTimeDao.save(theTime);
		}
	}

	@GetMapping("/getNumberOfUser/{username}/{idDiscount}")
	public Integer getNumberOfuser(@PathVariable("username") String username,@PathVariable("idDiscount")int idDiscount) {
		try {
			int value = theTimeDao.sp_findByUsernameAndDiscount(username, idDiscount).getNumberOfUse();
			return value;
		} catch (Exception e) {
			return 0;
		}
	}
}
