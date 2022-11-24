package com.nhathanh.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.Favourite;
import com.nhathanh.entity.Product;

public interface FavouriteDAO extends JpaRepository<Favourite, Integer> {
	@Query("SELECT p FROM Favourite p WHERE p.product.category.id=?1")
	List<Favourite> findByCategoryId(String id);	
	
	@Query("SELECT p FROM Favourite p WHERE p.account.username=?1")
	List<Favourite> findByUsername(String id);
	
	@Query("SELECT p.product.id FROM Favourite p WHERE p.account.username = ?1")
	List<Integer> findIdProduct(String username);
	
	@Query("SELECT p FROM Favourite p WHERE p.product.id=?1")
	Favourite findByProducId(Integer id);	
}
