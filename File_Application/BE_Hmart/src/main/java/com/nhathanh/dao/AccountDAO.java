package com.nhathanh.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.Account;

public interface AccountDAO extends JpaRepository<Account, String>{
	
	@Query(value = "exec checkUserOrdered  ?1, ?2", nativeQuery = true)
	Integer checkUserOrdered(String username, Integer idPr);
}
