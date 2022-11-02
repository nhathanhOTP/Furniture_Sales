package com.nhathanh.dao;
import org.springframework.data.jpa.repository.JpaRepository;
import com.nhathanh.entity.*;
public interface CategoryDAO extends JpaRepository<Category, String>{
    
}
