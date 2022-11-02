package com.nhathanh.dao;
import org.springframework.data.jpa.repository.JpaRepository;
import com.nhathanh.entity.*;
public interface RoleDAO extends JpaRepository<Role, String>{
    
}
