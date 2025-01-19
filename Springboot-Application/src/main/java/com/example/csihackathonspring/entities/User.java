package com.example.csihackathonspring.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "users")
public class User {

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

    @JsonProperty("contract")
    private Contract contract;

    @JsonProperty("profile")
    private Profile profile;

    @JsonProperty("analytics")
    private Analytics analytics;

    @JsonProperty("distributionSettings")
    private DistributionSettings distributionSettings;

    @JsonProperty("registrationDate")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date registrationDate;

    @JsonProperty("createdAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date createdAt;

    @JsonProperty("updatedAt")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    private Date updatedAt;

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

    public DistributionSettings getDistributionSettings() {
        return distributionSettings;
    }

    public void setDistributionSettings(DistributionSettings distributionSettings) {
        this.distributionSettings = distributionSettings;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
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

    // Inner classes

    public static class Contract {

        @JsonProperty("network")
        private String network;

        @JsonProperty("totalMinted")
        private int totalMinted;

        @JsonProperty("deploymentStatus")
        private String deploymentStatus;

        @JsonProperty("address")
        private String address;

        @JsonProperty("blockExplorerUrl")
        private String blockExplorerUrl;

        @JsonProperty("deploymentDate")
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        private Date deploymentDate;

        @JsonProperty("transactionHash")
        private String transactionHash;

        @JsonProperty("transactionId")
        private String transactionId;

        // Getters and Setters

        public String getNetwork() {
            return network;
        }

        public void setNetwork(String network) {
            this.network = network;
        }

        public int getTotalMinted() {
            return totalMinted;
        }

        public void setTotalMinted(int totalMinted) {
            this.totalMinted = totalMinted;
        }

        public String getDeploymentStatus() {
            return deploymentStatus;
        }

        public void setDeploymentStatus(String deploymentStatus) {
            this.deploymentStatus = deploymentStatus;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getBlockExplorerUrl() {
            return blockExplorerUrl;
        }

        public void setBlockExplorerUrl(String blockExplorerUrl) {
            this.blockExplorerUrl = blockExplorerUrl;
        }

        public Date getDeploymentDate() {
            return deploymentDate;
        }

        public void setDeploymentDate(Date deploymentDate) {
            this.deploymentDate = deploymentDate;
        }

        public String getTransactionHash() {
            return transactionHash;
        }

        public void setTransactionHash(String transactionHash) {
            this.transactionHash = transactionHash;
        }

        public String getTransactionId() {
            return transactionId;
        }

        public void setTransactionId(String transactionId) {
            this.transactionId = transactionId;
        }
    }

    public static class Profile {

        @JsonProperty("followersCount")
        private int followersCount;

        @JsonProperty("artworksCount")
        private int artworksCount;

        @JsonProperty("followingCount")
        private int followingCount;

        @JsonProperty("salesCount")
        private int salesCount;

        // Getters and Setters

        public int getFollowersCount() {
            return followersCount;
        }

        public void setFollowersCount(int followersCount) {
            this.followersCount = followersCount;
        }

        public int getArtworksCount() {
            return artworksCount;
        }

        public void setArtworksCount(int artworksCount) {
            this.artworksCount = artworksCount;
        }

        public int getFollowingCount() {
            return followingCount;
        }

        public void setFollowingCount(int followingCount) {
            this.followingCount = followingCount;
        }

        public int getSalesCount() {
            return salesCount;
        }

        public void setSalesCount(int salesCount) {
            this.salesCount = salesCount;
        }
    }

    public static class Analytics {

        @JsonProperty("totalArtworksListed")
        private int totalArtworksListed;

        @JsonProperty("totalSalesValue")
        private int totalSalesValue;

        @JsonProperty("averagePrice")
        private int averagePrice;

        @JsonProperty("totalViews")
        private int totalViews;

        @JsonProperty("totalLikes")
        private int totalLikes;

        // Getters and Setters

        public int getTotalArtworksListed() {
            return totalArtworksListed;
        }

        public void setTotalArtworksListed(int totalArtworksListed) {
            this.totalArtworksListed = totalArtworksListed;
        }

        public int getTotalSalesValue() {
            return totalSalesValue;
        }

        public void setTotalSalesValue(int totalSalesValue) {
            this.totalSalesValue = totalSalesValue;
        }

        public int getAveragePrice() {
            return averagePrice;
        }

        public void setAveragePrice(int averagePrice) {
            this.averagePrice = averagePrice;
        }

        public int getTotalViews() {
            return totalViews;
        }

        public void setTotalViews(int totalViews) {
            this.totalViews = totalViews;
        }

        public int getTotalLikes() {
            return totalLikes;
        }

        public void setTotalLikes(int totalLikes) {
            this.totalLikes = totalLikes;
        }
    }

    public static class DistributionSettings {

        @JsonProperty("galleryShare")
        private int galleryShare;

        @JsonProperty("artistShare")
        private int artistShare;

        @JsonProperty("platformFee")
        private int platformFee;

        // Getters and Setters

        public int getGalleryShare() {
            return galleryShare;
        }

        public void setGalleryShare(int galleryShare) {
            this.galleryShare = galleryShare;
        }

        public int getArtistShare() {
            return artistShare;
        }

        public void setArtistShare(int artistShare) {
            this.artistShare = artistShare;
        }

        public int getPlatformFee() {
            return platformFee;
        }

        public void setPlatformFee(int platformFee) {
            this.platformFee = platformFee;
        }
    }
}
