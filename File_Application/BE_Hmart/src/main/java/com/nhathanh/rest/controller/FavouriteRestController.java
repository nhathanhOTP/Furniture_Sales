package com.nhathanh.rest.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nhathanh.dao.CategoryDAO;
import com.nhathanh.dao.ProductDAO;
import com.nhathanh.entity.Category;
import com.nhathanh.entity.Product;


@CrossOrigin("*")
@RestController
public class FavouriteRestController {
	@Autowired
	ProductDAO productDao;
	
	@Autowired
	FavouriteDAO favourDao;
	
	@Autowired
	AccountDAO accDao;
	
	@GetMapping("/hfn/favour/getAll")
	public List<Favourite> getAll(){
		return favourDao.findAll();
	}
	
	@GetMapping("/hfn/favour/cate/{id}")
	public List<Favourite> getByCate(@PathVariable("id") String id) {
		return favourDao.findByCategoryId(id);
	}
	
	@GetMapping("/hfn/favour/idPrList/{username}")
	public List<Integer> getListId(@PathVariable("username") String username) {
		return favourDao.findIdProduct(username);
	}
	
	@GetMapping("/hfn/favour/user/{id}")
	public List<Favourite> getByUser(@PathVariable("id") String id) {
		return favourDao.findByUsername(id);
	}
	
	@PostMapping("/hfn/favour/add")
	public Favourite add(@RequestBody Favourite fav){
		fav.setAccount(accDao.findById(fav.getAccount().getUsername()).get());
		fav.setProduct(productDao.findById(fav.getProduct().getId()).get());
		Date date = new Date();
		fav.setDatecreate(date);
		favourDao.save(fav);
		return fav;
	}
	
	
	@GetMapping("/hfn/favour/checkExist/{idPr}")
	public Boolean checkE(@PathVariable Integer id) {	
		try {
			favourDao.findByProducId(id);
			return true;
		}catch(Exception e) {
			return false;
		}	
	}
	
	@DeleteMapping("/hfn/favour/delete/{id}")
	public String delete(@PathVariable("id") Integer id){
		favourDao.deleteById(id);
		return "Done!";
	}
}
