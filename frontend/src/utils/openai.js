const OPENAI_API_KEY = "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";

export const enhancePrompt = async (userPrompt) => {
  try {
    const response = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${OPENAI_API_KEY}`
      },
      body: JSON.stringify({
        model: "gpt-3.5-turbo",
        messages: [{
          role: "system",
          content: "You are an expert at creating detailed, vivid prompts for NFT art generation. Convert user inputs into detailed, artistic prompts that will result in high-quality, unique NFT artwork. Focus on adding artistic style, lighting, mood, and technical details."
        }, {
          role: "user",
          content: `Convert this prompt into a detailed NFT art prompt: "${userPrompt}"`
        }],
        temperature: 0.7,
        max_tokens: 200
      })
    });

    if (!response.ok) {
      const errorData = await response.json();
      throw new Error(errorData.error?.message || `HTTP error! status: ${response.status}`);
    }

    const data = await response.json();
    
    if (!data.choices || !data.choices[0] || !data.choices[0].message) {
      throw new Error('Invalid response format from OpenAI');
    }

    return data.choices[0].message.content;
  } catch (error) {
    console.error('🔴 OpenAI API Error:', error);
    // Return a enhanced version without API if there's an error
    return `${userPrompt}, digital art style, highly detailed, intricate, elegant, sharp focus, concept art, character design, trending on artstation, cinematic lighting, dynamic composition`;
  }
}; 