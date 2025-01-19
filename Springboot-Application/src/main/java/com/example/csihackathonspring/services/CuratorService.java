package com.example.csihackathonspring.services;

import com.example.csihackathonspring.entities.Curator;
import com.example.csihackathonspring.repositories.CuratorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CuratorService {

    private final CuratorRepository curatorRepository;

    @Autowired
    public CuratorService(CuratorRepository curatorRepository) {
        this.curatorRepository = curatorRepository;
    }

    // Fetch curator by ID
    public Optional<Curator> getCuratorById(String id) {
        return curatorRepository.findById(id);
    }

    // Fetch curator by username
    public Optional<Curator> getCuratorByUsername(String username) {
        return curatorRepository.findByUsername(username);
    }
}
