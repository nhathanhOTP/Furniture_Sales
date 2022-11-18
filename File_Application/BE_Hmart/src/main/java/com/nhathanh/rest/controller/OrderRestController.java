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
	OrderDetailDAO orderDetailDao;
	
	@Autowired
	OrderStatusDAO orderStatusDao;
	
	@GetMapping("/hfn/order/getAll")
	public List<Order> getAll(){
		return orderDao.findAll();
	}
	
	@GetMapping("/hfn/order/user/{username}")
	public List<Order> getByUser(@PathVariable("username")String username){
		return orderDao.findByUsername(username);
	}
	
	@GetMapping("/hfn/order/detail/{id}")
	public Order getDetail(@PathVariable("id")Long id){
		return orderDao.findById(id).get();
	}
	
	@GetMapping("/hfn/order/listDetail/{id}")
	public List<OrderDetail> getOrderDetail(@PathVariable("id")Long id){
		return orderDetailDao.findByOrder(id);
	}
	
	@PutMapping("/hfn/order/update/{id}")
	public Order updateStatus(@PathVariable("id")Long id, @RequestBody Integer statusId){
		orderDao.updateStatus(statusId, id);
		return orderDao.findById(id).get();
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
