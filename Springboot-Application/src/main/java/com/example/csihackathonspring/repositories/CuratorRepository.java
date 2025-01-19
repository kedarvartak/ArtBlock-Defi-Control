package com.example.csihackathonspring.repositories;

import com.example.csihackathonspring.entities.Curator;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CuratorRepository extends MongoRepository<Curator, String> {
    Optional<Curator> findByUsername(String username);
}
