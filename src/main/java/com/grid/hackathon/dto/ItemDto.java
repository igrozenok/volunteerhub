package com.grid.hackathon.dto;

import com.grid.hackathon.entity.ItemStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ItemDto {

    private Long id;
    private Long requestId;
    private String category;
    private String summary;
    private String description;
    private ItemStatus status;
    private Long closedByUser;

}
