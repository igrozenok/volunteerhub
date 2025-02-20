package com.grid.hackathon.service;

import com.grid.hackathon.dto.UserDto;
import com.grid.hackathon.entity.User;
import com.grid.hackathon.exception.NotFoundException;
import com.grid.hackathon.mapper.UserMapper;
import com.grid.hackathon.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public UserDto getUserById(String userLogin) {
        User user = userRepository.findByLogin(userLogin)
                                  .orElseThrow(() -> new NotFoundException("User not found"));
        return UserMapper.mapToDto(user);
    }

    public List<UserDto> findAll() {
        List<User> all = userRepository.findAll();
        return UserMapper.mapToDto(all);
    }
}
