package com.example.csihackathonspring.controllers;

import com.example.csihackathonspring.entities.Investor;
import com.example.csihackathonspring.services.InvestorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/investors")
public class InvestorController {

    private final InvestorService investorService;

    @Autowired
    public InvestorController(InvestorService investorService) {
        this.investorService = investorService;
    }

    // Fetch investor by ID
    @GetMapping("/{id}")
    public ResponseEntity<Investor> getInvestorById(@PathVariable String id) {
        Optional<Investor> investor = investorService.getInvestorById(id);
        if (investor.isPresent()) {
            return ResponseEntity.ok(investor.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    // Fetch investor by username
    @GetMapping("/username/{username}")
    public ResponseEntity<Investor> getInvestorByUsername(@PathVariable String username) {
        Optional<Investor> investor = investorService.getInvestorByUsername(username);
        if (investor.isPresent()) {
            return ResponseEntity.ok(investor.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
