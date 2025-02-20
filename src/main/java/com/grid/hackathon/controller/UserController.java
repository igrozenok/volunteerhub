package com.grid.hackathon.controller;

import com.grid.hackathon.dto.UserDto;
import com.grid.hackathon.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/{userLogin}")
    public UserDto getUserByLogin(@PathVariable String userLogin) {
        return userService.getUserById(userLogin);
    }

    @GetMapping
    public List<UserDto> getAllUsers() {
        return userService.findAll();
    }
//
//    @PostMapping
//    public User createUser(@RequestBody User user) {
//        return userService.save(user);
//    }
//
//    @PutMapping("/{id}")
//    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User updatedUser) {
//        return userService.findById(id)
//                          .map(user -> {
//                                 user.setLogin(updatedUser.getLogin());
//                                 user.setFirstName(updatedUser.getFirstName());
//                                 user.setLastName(updatedUser.getLastName());
//                                 user.setRole(updatedUser.getRole());
//                                 user.setUserDetails(updatedUser.getUserDetails());
//                                 user.setUpdatedTs(updatedUser.getUpdatedTs());
//                                 return ResponseEntity.ok(userService.save(user));
//                             })
//                          .orElse(ResponseEntity.notFound().build());
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
//        if (userService.existsById(id)) {
//            userService.deleteById(id);
//            return ResponseEntity.noContent().build();
//        }
//        return ResponseEntity.notFound().build();
//    }

}
