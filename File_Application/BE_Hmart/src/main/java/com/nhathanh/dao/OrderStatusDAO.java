package com.nhathanh.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.nhathanh.entity.*;

public interface OrderStatusDAO extends JpaRepository<OrderStatus, Integer> {

}
