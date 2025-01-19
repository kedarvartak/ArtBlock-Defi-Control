package com.example.csihackathonspring.entities;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;

@Document(collection = "curators")
public class Curator {

    @Id
    private String id;

    @JsonProperty("username")
    private String username;

    @JsonProperty("password")
    private String password;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getWalletAddress() {
        return walletAddress;
    }

    public void setWalletAddress(String walletAddress) {
        this.walletAddress = walletAddress;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public Analytics getAnalytics() {
        return analytics;
    }

    public void setAnalytics(Analytics analytics) {
        this.analytics = analytics;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @JsonProperty("walletAddress")
    private String walletAddress;

    @JsonProperty("role")
    private String role;

    @JsonProperty("contract")
    private Contract contract;

    @JsonProperty("profile")
    private Profile profile;

    @JsonProperty("analytics")
    private Analytics analytics;

    @JsonProperty("createdAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date createdAt;

    @JsonProperty("updatedAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date updatedAt;

    // Getters and Setters

    // Nested Classes for Contract, Profile, and Analytics

    public static class Contract {
        @JsonProperty("network")
        private String network;

        @JsonProperty("galleries")
        private List<String> galleries;

        @JsonProperty("totalRevenue")
        private String totalRevenue;

        @JsonProperty("pendingRevenue")
        private String pendingRevenue;

        // Getters and Setters
    }

    public static class Profile {
        @JsonProperty("displayName")
        private String displayName;

        @JsonProperty("galleriesCount")
        private int galleriesCount;

        // Getters and Setters
    }

    public static class Analytics {
        @JsonProperty("totalArtistsCurated")
        private int totalArtistsCurated;

        @JsonProperty("totalVisitors")
        private int totalVisitors;

        @JsonProperty("totalArtworksSold")
        private int totalArtworksSold;

        // Getters and Setters
    }
}
