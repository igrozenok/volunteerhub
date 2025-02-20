package com.grid.hackathon.controller;

import com.grid.hackathon.dto.ItemDto;
import com.grid.hackathon.dto.RequestDto;
import com.grid.hackathon.dto.UpdateRequestStatusDto;
import com.grid.hackathon.service.RequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("api/v1/request")
@RequiredArgsConstructor
public class RequestController {

    private final RequestService requestService;

    //GET request?categories=a,b,c

    @GetMapping
    public List<RequestDto> getRequestsByCategories(
            @RequestParam(required = false) List<String> categories,
            @RequestHeader Long userId
    ) {
        return requestService.findAll(categories, userId);
    }

    @GetMapping("/{requestId}")
    public RequestDto getRequestById(@PathVariable Long requestId) {
        return requestService.findById(requestId);
    }

    @PostMapping
    public RequestDto createRequest(@RequestBody RequestDto request) {
        return requestService.save(request);
    }

    @PatchMapping("/{requestId}/status")
    public RequestDto updateRequestStatus(
            @PathVariable Long requestId,
            @RequestBody UpdateRequestStatusDto dto
    ) {

        return requestService.updateStatus(requestId, dto.getStatus());
    }

    @PostMapping("/{requestId}/item")
    public RequestDto addItemToRequest(@PathVariable Long requestId, @RequestBody ItemDto itemDto) {
        return requestService.addItemToRequest(requestId, itemDto);
    }
}
