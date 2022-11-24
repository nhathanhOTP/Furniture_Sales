package com.nhathanh.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.Evaluate;
import com.nhathanh.entity.Favourite;

public interface EvaluateDAO  extends JpaRepository<Evaluate, Integer>{
	@Query("SELECT p FROM Evaluate p WHERE p.product.id=?1")
	List<Evaluate> findByProductId(Integer id);
}
