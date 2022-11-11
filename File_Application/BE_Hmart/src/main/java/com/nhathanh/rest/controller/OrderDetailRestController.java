package com.nhathanh.rest.controller;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;

@CrossOrigin("*")
@RestController
public class OrderDetailRestController {
	@Autowired
	AccountDAO accountDao;
	
	@Autowired
	OrderDetailDAO orderDetailDao;
	
	@Autowired
	OrderDAO orderDao;
	
	@Autowired
	ProductDAO productDao;
	
	@GetMapping("/hfn/OrderDetail/getAll")
	public List<OrderDetail> getAll(){
		return orderDetailDao.findAll();
	}
	
	@GetMapping("/hfn/OrderDetail/{id}")
	public OrderDetail getOne(@PathVariable("id") Long id) {
		return orderDetailDao.findById(id).get();
	}
	
	@PostMapping("/hfn/OrderDetail/save/{orderId}")
	public List<Item> confirmOrderDetail(@PathVariable("orderId") Long orderId,  @RequestBody List<Item> item) {
		for (Item item2 : item) {
			OrderDetail ord = new OrderDetail();
			ord.setOrder(orderDao.findById(orderId).get());
			ord.setQuantity(item2.getQuantity());
			ord.setPrice(item2.getPrice() * item2.getQuantity());
			ord.setProduct(productDao.findById(item2.getId()).get());
			orderDetailDao.save(ord);
		}
		return item;
	}

}
