package com.nhathanh.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.Product;

public interface ProductDAO extends JpaRepository<Product, Integer> {
	@Query("SELECT p FROM Product p WHERE p.category.id=?1")
	List<Product> findByCategoryId(String id);
	
	@Query("SELECT p FROM Product p WHERE p.id LIKE ?1 or p.name LIKE ?1 or p.price LIKE ?1 "
			+ "or p.createDate LIKE ?1 or p.category.name LIKE ?1 or p.image LIKE ?1")
	List<Product> findProduct(String request);
	
}
