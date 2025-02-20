package com.grid.hackathon.dto;

import com.grid.hackathon.entity.RequestStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RequestDto {

    private Long id;
    private Long userId;
    private String summary;
    private String description;
    private RequestStatus status;
    private List<ItemDto> items;

}
