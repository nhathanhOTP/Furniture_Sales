package com.nhathanh.dao;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.nhathanh.entity.Order;
public interface OrderDAO extends JpaRepository<Order, Long>{
	@Query("SELECT o FROM Order o WHERE o.account.username=?1")
	List<Order> findByUsername(String username);
	
	@Query(value = "exec find_Order_id ?1, ?2", nativeQuery = true)
	Long findIdOrder(String username, Integer status);
	
	@Transactional
	@Modifying
	@Query("UPDATE Order o SET o.orderStatus.id = ?1 WHERE o.id = ?2")
	void updateStatus(Integer newStatus, Long id);
}
