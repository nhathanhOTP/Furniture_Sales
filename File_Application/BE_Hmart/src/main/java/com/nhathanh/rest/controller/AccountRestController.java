package com.nhathanh.rest.controller;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

	//Hien thi hinh anh da duoc upload tu folder Image Account
    @RequestMapping("/hfn/getImage/{image}")
    @ResponseBody
    public ResponseEntity<ByteArrayResource> getImage(@PathVariable("image") String image){

    	if(!image.equals(null) || image != null) {
    		try {
    			Path filename = Paths.get("Image Account", image);
    			byte[] buffer = Files.readAllBytes(filename);
    			ByteArrayResource bar = new ByteArrayResource(buffer);
    			return ResponseEntity.ok()
    					.contentLength(buffer.length)
    					.contentType(MediaType.parseMediaType("image/" + image.substring(image.indexOf(".") + 1, image.length())))
    					.body(bar);
    		}
    		catch(Exception e) {
    			
    		}
    	}
    	
		return ResponseEntity.badRequest().build();
    }
    

    //Cap nhat thong tin profile cua account
    @PutMapping("/hfn/Account/updateProfile/{name}")
	public Account updateProfileAccount(@RequestBody Account account, @PathVariable("name") String name) {
    	account.setPhoto(name);
    	accountDao.save(account);
		return account;
	}
	
    //Upload anh da chon vao thu muc Image Account
    @PutMapping("/hfn/Account/upload")
   	public String upload(@RequestParam("file") MultipartFile image) {
       	Path path = Paths.get("Image Account/");
       	if(image != null) {
   	    	try {
   	    		InputStream inputStream = image.getInputStream();
   	    		Files.copy(inputStream, path.resolve(image.getOriginalFilename()), StandardCopyOption.REPLACE_EXISTING);
   	    	}catch(Exception e) {

   	    	}
       	}else {
       		System.out.println("Rỗng!");
       	}
   		return image.getOriginalFilename();
   	}
}
