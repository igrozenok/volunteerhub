package com.grid.hackathon.mapper;

import com.grid.hackathon.dto.UserDetailsDto;
import com.grid.hackathon.dto.UserDto;
import com.grid.hackathon.entity.Category;
import com.grid.hackathon.entity.User;
import com.grid.hackathon.entity.UserDetails;
import lombok.experimental.UtilityClass;

import java.util.List;

@UtilityClass
public class UserMapper {

    public List<UserDto> mapToDto(List<User> users) {
        return users.stream().map(UserMapper::mapToDto).toList();
    }

    public UserDto mapToDto(User user) {
        if (user == null) {
            return null;
        }
        UserDetails userDetails = user.getUserDetails();
        UserDetailsDto userDetailsDto = UserDetailsDto.builder()
                                                      .id(userDetails.getId())
                                                      .phone(userDetails.getPhone())
                                                      .address(userDetails.getAddress())
                                                      .description(userDetails.getDescription())
                                                      .build();
        List<String> categories = user.getCategories().stream().map(Category::getName).toList();
        return UserDto.builder()
                      .id(user.getId())
                      .login(user.getLogin())
                      .firstName(user.getFirstName())
                      .lastName(user.getLastName())
                      .role(user.getRole())
                      .userDetails(userDetailsDto)
                      .categories(categories)
                      .build();
    }

}
