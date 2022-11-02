package com.nhathanh.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nhathanh.entity.Conditions;

public interface ConditionsDAO extends JpaRepository<Conditions, Integer>{

}
