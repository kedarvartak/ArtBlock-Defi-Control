package com.example.csihackathonspring.services;

import com.example.csihackathonspring.entities.Investor;
import com.example.csihackathonspring.repositories.InvestorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class InvestorService {

    private final InvestorRepository investorRepository;

    @Autowired
    public InvestorService(InvestorRepository investorRepository) {
        this.investorRepository = investorRepository;
    }

    // Fetch investor by ID
    public Optional<Investor> getInvestorById(String id) {
        return investorRepository.findById(id);
    }

    // Fetch investor by username
    public Optional<Investor> getInvestorByUsername(String username) {
        return investorRepository.findByUsername(username);
    }
}
