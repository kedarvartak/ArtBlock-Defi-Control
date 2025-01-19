package com.example.csihackathonspring.repositories;

import com.example.csihackathonspring.entities.Investor;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InvestorRepository extends MongoRepository<Investor, String> {
    Optional<Investor> findByUsername(String username);
}
