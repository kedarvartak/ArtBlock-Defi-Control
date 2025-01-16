const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Creating gallery with account:", deployer.address);

  // Connect to the new GalleryFactory
  const galleryFactory = await hre.ethers.getContractAt(
    "GalleryFactory",
    "0xAa29DDBa855692326F42F941142C7d6C741A350d"  // Your new GalleryFactory address
  );

  try {
    console.log("Creating new gallery...");
    const tx = await galleryFactory.createGallery(
      "My New Gallery",  // gallery name
      "A test gallery description"  // gallery description
    );

    console.log("Waiting for transaction...");
    const receipt = await tx.wait();
    console.log("Transaction confirmed:", receipt.hash);

    // Get galleries for the deployer
    const galleries = await galleryFactory.getCuratorGalleries(deployer.address);
    console.log("\nYour galleries:", galleries);
    console.log("\nUse the most recent gallery address for minting NFTs");

  } catch (error) {
    console.error("Error creating gallery:", error);
    if (error.reason) console.error("Reason:", error.reason);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });