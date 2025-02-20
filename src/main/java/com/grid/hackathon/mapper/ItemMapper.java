package com.grid.hackathon.mapper;

import com.grid.hackathon.dto.ItemDto;
import com.grid.hackathon.dto.RequestDto;
import com.grid.hackathon.entity.Category;
import com.grid.hackathon.entity.Item;
import com.grid.hackathon.entity.Request;
import com.grid.hackathon.exception.NotFoundException;
import lombok.experimental.UtilityClass;

import java.util.List;

@UtilityClass
public class ItemMapper {

    public List<ItemDto> mapToDto(List<Item> items) {
        return items.stream().map(ItemMapper::mapToDto).toList();
    }

    public ItemDto mapToDto(Item item) {
        return ItemDto.builder()
                      .id(item.getId())
                      .requestId(item.getRequest().getId())
                      .category(item.getCategory().getName())
                      .summary(item.getSummary())
                      .description(item.getDescription())
                      .status(item.getStatus())
                      .closedByUser(item.getClosedByUserId())
                      .build();
    }

    public List<Item> mapToEntity(List<ItemDto> items, List<Category> categories, Request request) {
        return items.stream().map(itemDto -> {
            Category category = categories.stream()
                                          .filter(cat -> cat.getName().equals(itemDto.getCategory()))
                                          .findFirst()
                                          .orElseThrow(() -> new NotFoundException(
                                                  "Category not found for %s".formatted(itemDto.getCategory())));
            return ItemMapper.mapToEntity(itemDto, category, request);
        }).toList();
    }

    public Item mapToEntity(ItemDto itemDto, Category category, Request request) {

        Item item = new Item();
        item.setId(itemDto.getId());
        item.setRequest(request);
        item.setCategory(category);
        item.setSummary(itemDto.getSummary());
        item.setDescription(itemDto.getDescription());
        item.setStatus(itemDto.getStatus());
        item.setClosedByUserId(itemDto.getClosedByUser());
        return item;
    }
}
