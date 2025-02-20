package com.grid.hackathon.dto;

import com.grid.hackathon.entity.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    private Long id;
    private String login;
    private String firstName;
    private String lastName;
    private Role role;
    private UserDetailsDto userDetails;
    private List<String> categories;

}
