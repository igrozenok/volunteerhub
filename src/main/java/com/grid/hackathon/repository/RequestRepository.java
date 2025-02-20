package com.grid.hackathon.repository;

import com.grid.hackathon.entity.Category;
import com.grid.hackathon.entity.Request;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RequestRepository extends JpaRepository<Request, Long> {

    List<Request> findDistinctByItemsCategoryIn(List<Category> categories);

    List<Request> findByUserIdAndItemsCategoryIn(Long userId, List<Category> categories);

    List<Request> findByUserId(Long userId);

}
