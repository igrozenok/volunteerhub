package com.grid.hackathon.service;

import com.grid.hackathon.dto.ItemDto;
import com.grid.hackathon.entity.Item;
import com.grid.hackathon.mapper.ItemMapper;
import com.grid.hackathon.repository.ItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ItemService {
    private final ItemRepository itemRepository;

    public List<ItemDto> findAll() {
        List<Item> items = itemRepository.findAll();
        return ItemMapper.mapToDto(items);
    }

}
