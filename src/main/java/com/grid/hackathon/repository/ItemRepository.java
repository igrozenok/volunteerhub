package com.grid.hackathon.repository;

import com.grid.hackathon.entity.Item;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ItemRepository extends JpaRepository<Item, Long> {

}
