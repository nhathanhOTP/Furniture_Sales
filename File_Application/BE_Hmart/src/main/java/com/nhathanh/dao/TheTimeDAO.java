package com.nhathanh.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.nhathanh.entity.TheTimeUsed;

public interface TheTimeDAO extends JpaRepository<TheTimeUsed, Integer> {

	@Query(value = "exec sp_findTheTimeOfUser ?1", nativeQuery = true)
	public TheTimeUsed findTheTimeOfUser(String data);

	@Query(value = "exec sp_findByUsernameAndDiscount ?1,?2", nativeQuery = true)
	public TheTimeUsed sp_findByUsernameAndDiscount(String username, Integer idDiscount);

}
