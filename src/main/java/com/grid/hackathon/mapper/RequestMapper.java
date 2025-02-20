package com.grid.hackathon.mapper;

import com.grid.hackathon.dto.ItemDto;
import com.grid.hackathon.dto.RequestDto;
import com.grid.hackathon.entity.Category;
import com.grid.hackathon.entity.Item;
import com.grid.hackathon.entity.Request;
import com.grid.hackathon.entity.User;
import lombok.experimental.UtilityClass;

import java.util.List;

@UtilityClass
public class RequestMapper {

    public List<RequestDto> mapToDto(List<Request> requests) {
        return requests.stream().map(RequestMapper::mapToDto).toList();
    }

    public RequestDto mapToDto(Request request) {
        List<ItemDto> itemDtos = request.getItems().stream().map(ItemMapper::mapToDto).toList();
        return RequestDto.builder()
                         .id(request.getId())
                         .userId(request.getUser().getId())
                         .summary(request.getSummary())
                         .description(request.getDescription())
                         .status(request.getStatus())
                         .items(itemDtos)
                         .build();
    }

    public Request mapToEntity(RequestDto request, User user, List<Category> categories) {
        Request requestEntity = new Request();
        List<Item> items = ItemMapper.mapToEntity(request.getItems(), categories, requestEntity);
        requestEntity.setId(request.getId());
        requestEntity.setUser(user);
        requestEntity.setSummary(request.getSummary());
        requestEntity.setDescription(request.getDescription());
        requestEntity.setStatus(request.getStatus());
        requestEntity.setItems(items);
        return requestEntity;
    }
}
