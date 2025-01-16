import { generateImageHash } from './imageHash';
import { checkImageHashExists, storeNFTData } from './api';

const HF_API_TOKEN = "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";
const MODEL_URL = "https://api-inference.huggingface.co/models/strangerzonehf/Flux-NFTv4-Designs-LoRA";

// Keep track of recent prompts
const recentPrompts = new Set();

const generateUniquePrompt = (basePrompt, attempt = 0) => {
  const timestamp = Date.now();
  const randomSeed = Math.random().toString(36).substring(7);
  const uniqueIdentifier = `${timestamp}-${randomSeed}`;
  
  // Clean the prompt for comparison (remove timestamps and seeds)
  const cleanPrompt = basePrompt.replace(/\[seed:[^\]]+\]/, '').trim();
  
  if (recentPrompts.has(cleanPrompt) || attempt > 0) {
    const variations = [
      'with slightly different lighting',
      'with modified background',
      'with alternative color scheme',
      'from a different angle',
      'with subtle texture changes'
    ];
    const variation = variations[attempt % variations.length];
    console.log(`🎨 Detected duplicate prompt! Adding variation "${variation}" to create unique NFT`);
    return `${basePrompt} ${variation} [seed:${uniqueIdentifier}]`;
  }
  
  // Store the clean prompt
  recentPrompts.add(cleanPrompt);
  // Keep set size manageable
  if (recentPrompts.size > 10) {
    recentPrompts.delete(recentPrompts.values().next().value);
  }
  
  return `${basePrompt} [seed:${uniqueIdentifier}]`;
};

export const generateUniqueImage = async (prompt, maxAttempts = 3) => {
  let attempt = 0;
  
  while (attempt < maxAttempts) {
    try {
      const uniquePrompt = generateUniquePrompt(prompt, attempt);
      console.log(`🔍 Using prompt: "${uniquePrompt}"`);
      
      const imageUrl = await generateImage(uniquePrompt);
      const imageHash = await generateImageHash(imageUrl);
      
      // Check if hash exists in PostgreSQL
      const exists = await checkImageHashExists(imageHash);
      
      if (exists) {
        console.log(`🔄 Hash ${imageHash} already exists. Attempting variation...`);
        attempt++;
        continue;
      }
      
      // Store in PostgreSQL
      await storeNFTData({
        imageHash,
        prompt: uniquePrompt,
        imageUrl,
        metadata: {
          generationAttempt: attempt,
          timestamp: new Date().toISOString()
        }
      });
      
      console.log(`✨ Successfully generated unique NFT on attempt ${attempt + 1}`);
      if (attempt > 0) {
        console.log(`🎯 Used variation to ensure uniqueness`);
      }
      
      return {
        imageUrl,
        imageHash,
        prompt: uniquePrompt
      };
      
    } catch (error) {
      console.error(`❌ Attempt ${attempt + 1} failed:`, error);
      attempt++;
    }
  }
  
  throw new Error('Failed to generate a unique image after multiple attempts');
};

// Simple cache implementation
const imageCache = new Map();

export const generateImage = async (prompt) => {
  // Check cache first
  if (imageCache.has(prompt)) {
    return imageCache.get(prompt);
  }

  try {
    const response = await fetch(MODEL_URL, {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${HF_API_TOKEN}`,
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: JSON.stringify({
        inputs: prompt,
        options: {
          wait_for_model: true,
          use_cache: true // Enable Hugging Face's caching
        }
      }),
    });

    // Handle queue status
    if (response.status === 503) {
      const { estimated_time } = await response.json();
      // Wait and retry
      await new Promise(resolve => setTimeout(resolve, estimated_time * 1000));
      return generateImage(prompt); // Retry
    }

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || `HTTP error! status: ${response.status}`);
    }

    const blob = await response.blob();
    const imageUrl = URL.createObjectURL(blob);
    
    // Cache the result
    imageCache.set(prompt, imageUrl);
    
    return imageUrl;
  } catch (error) {
    console.error("Error generating image:", error);
    throw error;
  }
}; 