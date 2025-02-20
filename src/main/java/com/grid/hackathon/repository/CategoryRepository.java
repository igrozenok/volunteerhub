package com.grid.hackathon.repository;

import com.grid.hackathon.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    List<Category> findDistinctByNameIn(Collection<String> names);

    Optional<Category> findByName(String name);

}
