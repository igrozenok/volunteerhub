package com.grid.hackathon.service;

import com.grid.hackathon.dto.ItemDto;
import com.grid.hackathon.dto.RequestDto;
import com.grid.hackathon.entity.Category;
import com.grid.hackathon.entity.Item;
import com.grid.hackathon.entity.Request;
import com.grid.hackathon.entity.RequestStatus;
import com.grid.hackathon.entity.User;
import com.grid.hackathon.exception.NotFoundException;
import com.grid.hackathon.mapper.ItemMapper;
import com.grid.hackathon.mapper.RequestMapper;
import com.grid.hackathon.repository.CategoryRepository;
import com.grid.hackathon.repository.ItemRepository;
import com.grid.hackathon.repository.RequestRepository;
import com.grid.hackathon.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final ItemRepository itemRepository;

    public List<RequestDto> findAll(List<String> categoryNames, Long userId) {
        User user = userRepository.findById(userId)
                                  .orElseThrow(() -> new NotFoundException("User for ID %s not found".formatted(userId)));
        return switch (user.getRole()) {
            case ADMIN, VOLUNTEER -> getAllRequests(categoryNames);
            case SOLDIER -> getAllMyRequests(userId);
        };
    }

    private List<RequestDto> getAllMyRequests(Long userId) {
        List<Request> requests = requestRepository.findByUserId(userId);
        return RequestMapper.mapToDto(requests);
    }

    private List<RequestDto> getAllRequests(List<String> categoryNames) {
        if (CollectionUtils.isEmpty(categoryNames)) {
            List<Request> all = requestRepository.findAll();
            return RequestMapper.mapToDto(all);
        }
        List<Category> categoryList = categoryRepository.findDistinctByNameIn(categoryNames);
        List<Request> distinctByItemsCategoryIn = requestRepository.findDistinctByItemsCategoryIn(categoryList);
        return RequestMapper.mapToDto(distinctByItemsCategoryIn);
    }

    public RequestDto findById(Long requestId) {
        Request request = requestRepository.findById(requestId)
                                           .orElseThrow(() -> new NotFoundException("Request with ID %s not found".formatted(
                                                   requestId)));
        return RequestMapper.mapToDto(request);
    }

    public RequestDto save(RequestDto request) {
        Long userId = request.getUserId();
        User user = userRepository.findById(userId)
                                  .orElseThrow(() -> new NotFoundException("User with ID %s not found".formatted(userId)));
        List<String> categoryNames = request.getItems().stream().map(ItemDto::getCategory).toList();
        List<Category> categories = categoryRepository.findDistinctByNameIn(categoryNames);
        Request entity = RequestMapper.mapToEntity(request, user, categories);
        Request save = requestRepository.save(entity);
        return RequestMapper.mapToDto(save);
    }

    public RequestDto updateStatus(Long requestId, RequestStatus status) {
        Request request = requestRepository.findById(requestId)
                                           .orElseThrow(() -> new NotFoundException("Request with ID %s not found".formatted(
                                                   requestId)));
        request.setStatus(status);
        return RequestMapper.mapToDto(requestRepository.save(request));
    }

    public RequestDto addItemToRequest(Long requestId, ItemDto itemDto) {
        Request request = requestRepository.findById(requestId)
                                           .orElseThrow(() -> new NotFoundException("Request with ID %s not found".formatted(
                                                   requestId)));
        Category category = categoryRepository.findByName(itemDto.getCategory())
                                              .orElseThrow(() -> new NotFoundException("Category with name %s not found".formatted(
                                                      itemDto.getCategory())));

        Item item = ItemMapper.mapToEntity(itemDto, category, request);
        request.getItems().add(item);
        Request save = requestRepository.save(request);
        return RequestMapper.mapToDto(save);
    }
}
