package com.nhathanh.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nhathanh.entity.Discount;

public interface DiscountDAO  extends JpaRepository<Discount, Integer>{

}
