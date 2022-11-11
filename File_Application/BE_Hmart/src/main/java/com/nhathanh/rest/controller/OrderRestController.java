package com.nhathanh.rest.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import com.nhathanh.dao.*;
import com.nhathanh.entity.*;

@CrossOrigin("*")
@RestController
public class OrderRestController {
	@Autowired
	AccountDAO accountDao;
	
	@Autowired
	OrderDAO orderDao;
	
	@Autowired
	OrderStatusDAO orderStatusDao;
	
	@GetMapping("/hfn/order/getAll")
	public List<Order> getAll(){
		return orderDao.findAll();
	}
	
	@GetMapping("/hfn/order/{id}")
	public Order getOne(@PathVariable("id") Long id) {
		return orderDao.findById(id).get();
	}
	
	@PostMapping("/hfn/order/save")
	public Long confirmOrder(@RequestBody Order order) {
		order.setOrderStatus(orderStatusDao.findById(1).get());
		orderDao.save(order);
		return orderDao.findIdOrder(order.getAccount().getUsername(), order.getOrderStatus().getId());
	}

}
