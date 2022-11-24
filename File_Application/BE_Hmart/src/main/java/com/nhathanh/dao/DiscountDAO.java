package com.nhathanh.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.Discount;

public interface DiscountDAO extends JpaRepository<Discount, Integer> {
	@Query(value = "exec sp_findDiscount ?1", nativeQuery = true)
	public Discount findDiscount(String data);
	
	@Query(value = "exec sp_discountAvali", nativeQuery = true)
	public List<Discount> getAllDiscountAvali();

}
