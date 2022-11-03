package com.nhathanh.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nhathanh.entity.Condition;

public interface ConditionsDAO extends JpaRepository<Condition, Integer>{

}
