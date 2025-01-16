import React, { useState, useRef, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Wand2, Info, Image as ImageIcon, Sparkles, AlertCircle, Download } from 'lucide-react';
import { generateImage, generateUniqueImage } from '../utils/huggingface';
import { debounce } from 'lodash';

const RetroBeams = () => {
  const beamsRef = useRef(null);
  const [mousePosition, setMousePosition] = useState({ x: 0, y: 0 });
  
  useEffect(() => {
    const handleMouseMove = (e) => {
      const { clientX, clientY } = e;
      const { innerWidth, innerHeight } = window;
      const x = (clientX / innerWidth) * 2 - 1;
      const y = (clientY / innerHeight) * 2 - 1;
      setMousePosition({ x, y });
    };

    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);

  return (
    <motion.div 
      ref={beamsRef}
      className="fixed inset-0 overflow-hidden pointer-events-none"
      style={{ zIndex: 0 }}
    >
      <div 
        className="absolute inset-0"
        style={{
          backgroundImage: `
            linear-gradient(to right, rgba(147, 197, 253, 0.07) 1px, transparent 1px),
            linear-gradient(to bottom, rgba(147, 197, 253, 0.07) 1px, transparent 1px)
          `,
          backgroundSize: '100px 100px',
          transform: `translateY(${mousePosition.y * 10}px)`,
          transition: 'transform 0.2s ease-out'
        }}
      />
    </motion.div>
  );
};

const AINFTGenerator = () => {
  const [prompt, setPrompt] = useState('');
  const [loading, setLoading] = useState(false);
  const [generatedImage, setGeneratedImage] = useState(null);
  const [error, setError] = useState(null);
  const [progress, setProgress] = useState(0);
  const progressInterval = useRef(null);
  const [previewPrompt, setPreviewPrompt] = useState('');
  const [generationAttempt, setGenerationAttempt] = useState(0);

  // Debounced preview update
  const updatePreview = debounce((newPrompt) => {
    setPreviewPrompt(newPrompt);
  }, 500);

  const handlePromptChange = (e) => {
    const newPrompt = e.target.value;
    setPrompt(newPrompt);
    updatePreview(newPrompt);
  };

  // Simulate progress during generation
  const startProgressSimulation = () => {
    setProgress(0);
    progressInterval.current = setInterval(() => {
      setProgress(prev => {
        if (prev >= 95) {
          clearInterval(progressInterval.current);
          return prev;
        }
        return prev + Math.random() * 15;
      });
    }, 1000);
  };

  const stopProgressSimulation = () => {
    clearInterval(progressInterval.current);
    setProgress(100);
    setTimeout(() => setProgress(0), 500);
  };

  const handleGenerate = async () => {
    setLoading(true);
    setError(null);
    startProgressSimulation();
    
    try {
      const formattedPrompt = prompt.startsWith("NFT V4:") ? prompt : `NFT V4: ${prompt}`;
      const { imageUrl, imageHash, prompt: finalPrompt } = await generateUniqueImage(formattedPrompt);
      
      setGeneratedImage(imageUrl);
      console.log('Generated unique NFT with hash:', imageHash);
      console.log('Final prompt used:', finalPrompt);
      
    } catch (error) {
      setError(error.message || "Failed to generate unique image. Please try again.");
      console.error("Error:", error);
    } finally {
      stopProgressSimulation();
      setLoading(false);
    }
  };

  const handleDownload = () => {
    if (generatedImage) {
      const link = document.createElement('a');
      link.href = generatedImage;
      link.download = 'generated-nft.png';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0A] relative overflow-hidden">
      <RetroBeams />
      <div className="relative" style={{ zIndex: 1 }}>
        <div className="max-w-7xl mx-auto px-4 py-16">
          {/* Enhanced Header Section */}
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="text-center mb-16"
          >
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.2 }}
              className="inline-flex items-center gap-2 px-4 py-2 
                bg-white/5 backdrop-blur-lg rounded-full 
                border border-white/10 mb-6"
            >
              <div className="w-2 h-2 bg-[#6366F1] rounded-full animate-pulse" />
              <span className="text-white/80 text-sm font-['Plus_Jakarta_Sans'] font-medium">
                AI-Powered NFT Generation
              </span>
            </motion.div>

            <h1 className="text-7xl lg:text-8xl font-bold text-white leading-none 
              tracking-tight font-['Space_Grotesk'] mb-6"
            >
              <motion.span
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 }}
                className="block bg-gradient-to-r from-white via-white to-[#6366F1] 
                  bg-clip-text text-transparent"
              >
                Create Unique
              </motion.span>
              <motion.span
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.4 }}
                className="block text-[#6366F1]"
              >
                NFT Artwork
              </motion.span>
              <motion.span
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.5 }}
                className="block"
              >
                with AI
              </motion.span>
            </h1>

            <motion.p
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.6 }}
              className="text-xl text-white/60 max-w-2xl mx-auto font-['Plus_Jakarta_Sans']"
            >
              Transform your ideas into stunning NFT artwork using our advanced AI generator. 
              Perfect for artists, collectors, and creators.
            </motion.p>
          </motion.div>

          {/* Enhanced Main Content Grid */}
          <div className="grid md:grid-cols-2 gap-10 items-start">
            {/* Left Column - Input and Guidelines */}
            <div className="space-y-8">
              {/* Enhanced Prompt Input */}
              <motion.div 
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                className="bg-gradient-to-br from-white/[0.03] to-transparent 
                  border border-white/10 rounded-2xl p-8 backdrop-blur-xl"
              >
                <label className="block text-base font-medium text-white mb-3 
                  font-['Space_Grotesk']"
                >
                  Your NFT Prompt
                </label>
                <div className="relative">
                  <textarea
                    value={prompt}
                    onChange={handlePromptChange}
                    placeholder="Describe your NFT artwork in detail..."
                    className="w-full h-40 bg-black/20 border border-white/10 rounded-xl p-4 
                      text-white placeholder-white/40 focus:border-[#6366F1]/40 
                      focus:ring-[#6366F1]/40 transition-all duration-300 outline-none 
                      resize-none font-['Plus_Jakarta_Sans']"
                  />
                  
                </div>
                <button
                  onClick={handleGenerate}
                  disabled={loading || !prompt}
                  className={`mt-5 w-full py-4 rounded-xl font-medium flex items-center 
                    justify-center gap-2 font-['Space_Grotesk'] transition-all duration-300
                    ${loading || !prompt 
                      ? 'bg-white/5 text-white/40 cursor-not-allowed' 
                      : 'bg-gradient-to-r from-[#6366F1] to-purple-500 text-white cursor-pointer hover:shadow-lg hover:shadow-[#6366F1]/20'
                    }`}
                >
                  {loading ? (
                    <>
                      <div className="w-5 h-5 border-2 border-white/20 border-t-white 
                        rounded-full animate-spin"
                      />
                      Generating...
                    </>
                  ) : (
                    <>
                      <Wand2 className="w-5 h-5" />
                      Generate NFT
                    </>
                  )}
                </button>
              </motion.div>

              {/* Enhanced Guidelines */}
              <motion.div 
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                className="bg-gradient-to-br from-white/[0.03] to-transparent 
                  border border-white/10 rounded-2xl p-8 backdrop-blur-xl"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="p-2 bg-[#6366F1]/10 rounded-xl">
                    <Info className="w-5 h-5 text-[#6366F1]" />
                  </div>
                  <h3 className="text-xl text-white font-bold font-['Space_Grotesk']">
                    Prompt Guidelines
                  </h3>
                </div>
                <div className="space-y-5 text-base text-white/70 font-['Plus_Jakarta_Sans']">
                  <p className="flex items-start gap-2">
                    <Sparkles className="w-4 h-4 mt-1 text-[#6366F1]" />
                    <span>Be specific about visual elements: colors, style, mood, lighting, and composition</span>
                  </p>
                  <p className="flex items-start gap-2">
                    <Sparkles className="w-4 h-4 mt-1 text-[#6366F1]" />
                    <span>Include artistic style references: digital art, pixel art, watercolor, oil painting, etc.</span>
                  </p>
                  <p className="flex items-start gap-2">
                    <Sparkles className="w-4 h-4 mt-1 text-[#6366F1]" />
                    <span>Describe character details: expressions, poses, clothing, accessories</span>
                  </p>
                  <p className="flex items-start gap-2">
                    <AlertCircle className="w-4 h-4 mt-1 text-[#6366F1]" />
                    <span>Avoid copyrighted characters or explicit content</span>
                  </p>
                </div>
              </motion.div>
            </div>

            {/* Right Column - Preview and Example */}
            <div className="space-y-8">
              {/* Enhanced Generated Image Preview */}
              <motion.div 
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                className="bg-gradient-to-br from-white/[0.03] to-transparent 
                  border border-white/10 rounded-2xl p-8 backdrop-blur-xl"
              >
                <div className="flex items-center justify-between mb-6">
                  <div className="flex items-center gap-3">
                    <div className="p-2 bg-[#6366F1]/10 rounded-xl">
                      <ImageIcon className="w-5 h-5 text-[#6366F1]" />
                    </div>
                    <h3 className="text-xl font-bold text-white font-['Space_Grotesk']">Preview</h3>
                  </div>
                  {generatedImage && (
                    <motion.button
                      whileHover={{ scale: 1.05 }}
                      whileTap={{ scale: 0.95 }}
                      onClick={handleDownload}
                      className="p-2 bg-[#6366F1]/10 rounded-xl text-[#6366F1] 
                        hover:bg-[#6366F1]/20 transition-colors duration-200"
                    >
                      <Download className="w-5 h-5" />
                    </motion.button>
                  )}
                </div>
                
                <div className="aspect-square rounded-xl overflow-hidden bg-black/20 
                  border border-white/10 shadow-lg shadow-black/20"
                >
                  {loading ? (
                    <div className="w-full h-full flex items-center justify-center">
                      <div className="flex flex-col items-center gap-4">
                        <div className="w-10 h-10 border-4 border-[#6366F1]/20 
                          border-t-[#6366F1] rounded-full animate-spin"
                        />
                        <p className="text-white/60 text-sm font-['Plus_Jakarta_Sans']">
                          Generating your NFT...
                        </p>
                      </div>
                    </div>
                  ) : error ? (
                    <div className="w-full h-full flex items-center justify-center 
                      text-red-400 text-center p-4"
                    >
                      {error}
                    </div>
                  ) : generatedImage ? (
                    <img 
                      src={generatedImage} 
                      alt="Generated NFT" 
                      className="w-full h-full object-cover"
                    />
                  ) : (
                    <div className="w-full h-full flex items-center justify-center 
                      text-white/40 text-center p-4 font-['Plus_Jakarta_Sans']"
                    >
                      Your generated NFT will appear here
                    </div>
                  )}
                </div>
              </motion.div>

              {/* Enhanced Example Section */}
              <motion.div 
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                className="bg-gradient-to-br from-white/[0.03] to-transparent 
                  border border-white/10 rounded-2xl p-8 backdrop-blur-xl"
              >
                <div className="flex items-center gap-3 mb-6">
                  <div className="p-2 bg-[#6366F1]/10 rounded-xl">
                    <Sparkles className="w-5 h-5 text-[#6366F1]" />
                  </div>
                  <h3 className="text-xl font-bold text-white font-['Space_Grotesk']">Example</h3>
                </div>
                <div className="rounded-xl overflow-hidden mb-6 shadow-lg shadow-black/20">
                  <img 
                    src="https://huggingface.co/strangerzonehf/Flux-NFTv4-Designs-LoRA/resolve/main/images/6.png"
                    alt="Example NFT" 
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="text-base font-['Plus_Jakarta_Sans']">
                  <p className="font-medium text-white mb-3">Example Prompt:</p>
                  <p className="italic text-white/70 leading-relaxed">
                    "NFT V4: A raccoon depicted in a playful pose, wearing a green hoodie with a "Game Over" text on the front. 
                    The raccoons fur is a mix of brown and gray with white accents on its face. Its nose is black, and it has 
                    mischievous green eyes. The background is a pixelated video game landscape with floating clouds and coins."
                  </p>
                </div>
              </motion.div>
            </div>
          </div>
        </div>
      </div>

      {/* Background Decorations */}
      <motion.div
        animate={{ 
          rotate: [0, 360],
          scale: [1, 1.5, 1],
        }}
        transition={{ duration: 20, repeat: Infinity, repeatType: "reverse" }}
        className="absolute -top-1/2 -right-1/2 w-full h-full 
          bg-white/[0.02] rounded-full blur-3xl"
      />
      <motion.div
        animate={{ 
          rotate: [360, 0],
          scale: [1, 1.5, 1],
        }}
        transition={{ duration: 25, repeat: Infinity, repeatType: "reverse" }}
        className="absolute -bottom-1/2 -left-1/2 w-full h-full 
          bg-[#6366F1]/[0.02] rounded-full blur-3xl"
      />
    </div>
  );
};

export default AINFTGenerator; 