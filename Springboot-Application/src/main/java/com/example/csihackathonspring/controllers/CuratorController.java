package com.example.csihackathonspring.controllers;

import com.example.csihackathonspring.entities.Curator;
import com.example.csihackathonspring.services.CuratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/curators")
public class CuratorController {

    private final CuratorService curatorService;

    @Autowired
    public CuratorController(CuratorService curatorService) {
        this.curatorService = curatorService;
    }

    // Fetch curator by ID
    @GetMapping("/{id}")
    public ResponseEntity<Curator> getCuratorById(@PathVariable String id) {
        Optional<Curator> curator = curatorService.getCuratorById(id);
        return curator.map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    // Fetch curator by username
    @GetMapping("/username/{username}")
    public ResponseEntity<Curator> getCuratorByUsername(@PathVariable String username) {
        Optional<Curator> curator = curatorService.getCuratorByUsername(username);
        return curator.map(ResponseEntity::ok)
                .orElse(ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }
}
