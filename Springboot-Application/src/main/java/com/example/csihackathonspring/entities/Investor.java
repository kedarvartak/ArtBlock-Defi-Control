package com.example.csihackathonspring.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;

@Document(collection = "investors")
public class Investor {

    @Id
    private String id;

    @JsonProperty("username")
    private String username;

    @JsonProperty("password")
    private String password;

    @JsonProperty("walletAddress")
    private String walletAddress;

    @JsonProperty("role")
    private String role;

    @JsonProperty("profile")
    private Profile profile;

    @JsonProperty("analytics")
    private Analytics analytics;

    @JsonProperty("portfolio")
    private Portfolio portfolio;

    @JsonProperty("createdAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date createdAt;

    // Getters and Setters

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

    public Portfolio getPortfolio() {
        return portfolio;
    }

    public void setPortfolio(Portfolio portfolio) {
        this.portfolio = portfolio;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    // Inner classes

    public static class Profile {

        @JsonProperty("followersCount")
        private int followersCount;

        @JsonProperty("investmentsCount")
        private int investmentsCount;

        @JsonProperty("badges")
        private List<String> badges;

        // Getters and Setters

        public int getFollowersCount() {
            return followersCount;
        }

        public void setFollowersCount(int followersCount) {
            this.followersCount = followersCount;
        }

        public int getInvestmentsCount() {
            return investmentsCount;
        }

        public void setInvestmentsCount(int investmentsCount) {
            this.investmentsCount = investmentsCount;
        }

        public List<String> getBadges() {
            return badges;
        }

        public void setBadges(List<String> badges) {
            this.badges = badges;
        }
    }

    public static class Analytics {

        @JsonProperty("totalInvested")
        private int totalInvested;

        @JsonProperty("totalROI")
        private int totalROI;

        @JsonProperty("portfolioValue")
        private int portfolioValue;

        // Getters and Setters

        public int getTotalInvested() {
            return totalInvested;
        }

        public void setTotalInvested(int totalInvested) {
            this.totalInvested = totalInvested;
        }

        public int getTotalROI() {
            return totalROI;
        }

        public void setTotalROI(int totalROI) {
            this.totalROI = totalROI;
        }

        public int getPortfolioValue() {
            return portfolioValue;
        }

        public void setPortfolioValue(int portfolioValue) {
            this.portfolioValue = portfolioValue;
        }
    }

    public static class Portfolio {

        @JsonProperty("watchlist")
        private List<String> watchlist;

        @JsonProperty("investmentHistory")
        private List<String> investmentHistory;

        // Getters and Setters

        public List<String> getWatchlist() {
            return watchlist;
        }

        public void setWatchlist(List<String> watchlist) {
            this.watchlist = watchlist;
        }

        public List<String> getInvestmentHistory() {
            return investmentHistory;
        }

        public void setInvestmentHistory(List<String> investmentHistory) {
            this.investmentHistory = investmentHistory;
        }
    }
}
