<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)
const { data: movieData } = movieStore.movieComputed(movieSlug.value)
const isLoaded = ref(false)

function formatDate(dateString) {
  if (!dateString) return 'Unknown'
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

function formatCurrency(amount) {
  if (!amount) return 'Unknown'
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(amount)
}

function formatLanguage(code) {
  if (!code) return 'Unknown'
  const languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh': 'Chinese'
  }
  return languages[code] || code
}

const socialLinks = ref([
  { icon: 'facebook', url: '#', label: 'Facebook' },
  { icon: 'twitter', url: '#', label: 'Twitter' },
  { icon: 'instagram', url: '#', label: 'Instagram' }
])

const movieFacts = computed(() => {
  const movie = movieData.value
  if (!movie) return []

  return [
    {
      label: 'Status',
      value: movie.status || 'Released',
      icon: 'status'
    },
    {
      label: 'Original Language',
      value: formatLanguage(movie.language),
      icon: 'language'
    },
    {
      label: 'Production Budget',
      value: formatCurrency(movie.budget),
      icon: 'budget'
    },
    {
      label: 'Box Office Revenue',
      value: formatCurrency(movie.revenue),
      icon: 'revenue'
    },
    {
      label: 'Release Date',
      value: formatDate(movie.release_date),
      icon: 'calendar'
    }
  ].filter(fact => fact.value !== 'Unknown')
})

const keywords = computed(() =>
    movieData.value?.categories || []
)

onMounted(() => {
  setTimeout(() => {
    isLoaded.value = true
  }, 100)
})
</script>

<template>
  <div class="movie-sidebar" :class="{ 'is-loaded': isLoaded }">
    <!-- Social Share Panel -->
    <div class="social-share-panel">
      <div class="header">
        <span class="share-text">Share</span>
      </div>
      
      <div class="social-links-container">
        <a v-for="social in socialLinks"
           :key="social.icon"
           :href="social.url"
           :aria-label="social.label"
           class="social-btn">
          <div class="social-inner">
            <svg class="social-icon">
              <use :href="`#${social.icon}`"></use>
            </svg>
            <span class="social-highlight"></span>
          </div>
        </a>

        <a href="#" aria-label="Watch on JustWatch" class="social-btn">
          <div class="social-inner">
            <svg class="social-icon">
              <use href="#justwatch"></use>
            </svg>
            <span class="social-highlight"></span>
          </div>
        </a>

        <a href="#" aria-label="Copy link" class="social-btn">
          <div class="social-inner">
            <svg class="social-icon">
              <use href="#link"></use>
            </svg>
            <span class="social-highlight"></span>
          </div>
        </a>
      </div>
    </div>

    <!-- Movie Facts Panel -->
    <div v-if="movieFacts.length" class="movie-facts-panel">
        <div class="header">
          <span class="share-text">Facts</span>
        </div>
      
      <div class="facts-container">
        <div v-for="(fact, index) in movieFacts"
             :key="fact.label"
             class="fact-item"
             :style="{ '--delay': `${index * 0.1 + 0.2}s` }">
          <div class="fact-body">
            <div class="fact-decal"></div>
            <div class="fact-icon">
              <svg>
                <use :href="`#${fact.icon}`"></use>
              </svg>
              <span class="icon-reflection"></span>
            </div>
            <div class="fact-content">
              <div class="fact-label">{{ fact.label }}</div>
              <div class="fact-value">{{ fact.value }}</div>
            </div>
          </div>
          <div class="fact-hover-effect"></div>
        </div>
      </div>
    </div>

    <!-- Keywords Panel -->
    <div v-if="keywords.length" class="keywords-panel">
      <div class="header">
        <span class="share-text">Keywords</span>
      </div>
      
      <div class="keywords-container">
        <div v-for="(keyword, index) in keywords"
             :key="keyword"
             class="keyword-tag"
             :style="{ '--tag-delay': `${index * 0.08 + 0.3}s` }">
          <span class="keyword-inner">{{ keyword }}</span>
          <span class="keyword-glow"></span>
        </div>
      </div>
    </div>
  </div>
</template>

<style>

  
  .movie-sidebar {
    font-family: 'Plus Jakarta Sans', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    min-width: 295px;
    max-width: 320px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 36px;
    opacity: 0;
    transform: translateY(20px);
    transition: opacity 0.8s ease, transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
  }
  
  .movie-sidebar.is-loaded {
    opacity: 1;
    transform: translateY(0);
  }
  
  .social-share-panel {
    margin-bottom: 8px;
  }
  
  .header {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 16px;
  }
  
  .share-text {
    font-size: 0.75rem;
    font-weight: 500;
    color: rgba(26, 29, 41, 0.6);
    margin: 0 12px;
    text-transform: uppercase;
    letter-spacing: 0.08em;
  }
  
  .dark .share-text {
    color: var(--dark-text-secondary);
  }
  
  .share-line {
    height: 1px;
    flex-grow: 1;
    max-width: 50px;
    background: var(--light-gradient);
  }
  
  .social-links-container {
    display: flex;
    justify-content: center;
    gap: 16px;
  }
  
  .social-btn {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(8px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 4px 12px rgba(26, 29, 41, 0.06);
    transition: all 0.25s ease;
  }
  
  .dark .social-btn {
    background: rgba(1, 26, 48, 0.7);
    border: 1px solid var(--dark-border);
    box-shadow: 0 4px 12px var(--dark-shadow);
  }
  
  .social-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 24px rgba(93, 122, 226, 0.15);
    border-color: rgba(255, 255, 255, 0.2);
  }
  
  .dark .social-btn:hover {
    box-shadow: 0 8px 24px rgba(59, 130, 246, 0.2);
    border-color: rgba(59, 130, 246, 0.3);
  }
  
  .social-inner {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
  }
  
  .social-icon {
    width: 16px;
    height: 16px;
    color: var(--primary-dark);
    transition: color 0.25s ease;
  }
  
  .dark .social-icon {
    color: var(--dark-text-primary);
  }
  
  .social-btn:hover .social-icon {
    color: var(--secondary-accent);
  }
  
  .dark .social-btn:hover .social-icon {
    color: #3b82f6;
  }
  
  .social-highlight {
    position: absolute;
    width: 100%;
    height: 0;
    bottom: 0;
    left: 0;
    background: var(--medium-gradient);
    transition: height 0.25s ease;
    z-index: -1;
    border-radius: 50%;
    opacity: 0.7;
  }
  
  .dark .social-highlight {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.3), rgba(79, 70, 229, 0.3));
  }
  
  .social-btn:hover .social-highlight {
    height: 100%;
  }
  
  .movie-facts-panel {
    position: relative;
  }
  
  .facts-container {
    display: flex;
    flex-direction: column;
    gap: 14px;
  }
  
  .fact-item {
    position: relative;
    opacity: 0;
    transform: translateX(-10px);
    animation: fade-slide-in 0.6s forwards;
    animation-delay: var(--delay);
  }
  
  .fact-body {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 14px 18px;
    background: rgba(255, 255, 255, 0.7);
    border-radius: 14px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 14px rgba(26, 29, 41, 0.04);
    transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
  }
  
  .dark .fact-body {
    background: var(--dark-card-bg);
    border: 1px solid rgba(59, 130, 246, 0.1);
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.1);
  }
  
  .fact-decal {
    position: absolute;
    top: 0;
    left: 0;
    width: 0;
    height: 100%;
    border-radius: 14px 0 0 14px;
    background: var(--light-gradient);
    transition: width 0.25s cubic-bezier(0.16, 1, 0.3, 1);
    z-index: -1;
  }
  
  .dark .fact-decal {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(79, 70, 229, 0.2));
  }
  
  .fact-item:hover .fact-decal {
    width: 4px;
  }
  
  .fact-item:hover .fact-body {
    transform: translateX(4px);
    background: rgba(255, 255, 255, 0.85);
    border-color: rgba(93, 122, 226, 0.2);
    box-shadow: 0 8px 24px rgba(93, 122, 226, 0.1);
  }
  
  .dark .fact-item:hover .fact-body {
    background: rgba(1, 26, 48, 0.9);
    border-color: rgba(59, 130, 246, 0.3);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  }
  
  .fact-icon {
    width: 40px;
    height: 40px;
    min-width: 40px;
    border-radius: 12px;
    background: var(--light-gradient);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.3);
    transition: all 0.25s ease;
  }
  
  .dark .fact-icon {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(79, 70, 229, 0.1));
    border: 1px solid rgba(59, 130, 246, 0.2);
  }
  
  .fact-item:hover .fact-icon {
    background: var(--medium-gradient);
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(93, 122, 226, 0.15);
  }
  
  .dark .fact-item:hover .fact-icon {
    background: linear-gradient(135deg, rgba(59, 130, 246, 0.3), rgba(79, 70, 229, 0.3));
    box-shadow: 0 6px 12px rgba(59, 130, 246, 0.2);
  }
  
  .fact-icon svg {
    width: 18px;
    height: 18px;
    color: var(--primary-dark);
    transition: color 0.25s ease;
  }
  
  .dark .fact-icon svg {
    color: var(--dark-text-primary);
  }
  
  .fact-item:hover .fact-icon svg {
    color: var(--secondary-accent);
  }
  
  .dark .fact-item:hover .fact-icon svg {
    color: #3b82f6;
  }
  
  .icon-reflection {
    display: none;
  }
  
  .fact-content {
    flex-grow: 1;
  }
  
  .fact-label {
    font-size: 0.7rem;
    font-weight: 500;
    color: rgba(26, 29, 41, 0.5);
    margin-bottom: 4px;
    letter-spacing: 0.02em;
    transition: color 0.25s ease;
  }
  
  .dark .fact-label {
    color: var(--dark-text-secondary);
  }
  
  .fact-item:hover .fact-label {
   color: rgba(26, 29, 41, 0.7);
  }
  
  .dark .fact-item:hover .fact-label {
   color: rgba(255, 255, 255, 0.8);
  }
  
  .fact-value {
   font-size: 0.95rem;
   font-weight: 600;
   color: var(--primary-dark);
   transition: all 0.25s ease;
  }
  
  .dark .fact-value {
   color: var(--dark-text-primary);
  }
  
  .fact-item:hover .fact-value {
   transform: translateX(2px);
  }
  
  .fact-hover-effect {
   display: none;
  }
  
  .keywords-panel {
   position: relative;
  }
  
  .keywords-container {
   display: flex;
   flex-wrap: wrap;
   gap: 10px;
   align-items: flex-start;
   justify-content: center;
  }
  
  .keyword-tag {
   position: relative;
   border-radius: 100px;
   overflow: hidden;
   padding: 1px;
   background: var(--light-gradient);
   opacity: 0;
   transform: translateY(10px);
   animation: pop-in 0.5s forwards;
   animation-delay: var(--tag-delay);
  }
  
  .dark .keyword-tag {
   background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(79, 70, 229, 0.2));
  }
  
  .keyword-inner {
   display: block;
   padding: 8px 14px;
   font-size: 0.75rem;
   font-weight: 500;
   color: var(--primary-dark);
   background: rgba(255, 255, 255, 0.85);
   border-radius: 100px;
   transition: all 0.25s ease;
   letter-spacing: 0.01em;
  }
  
  .dark .keyword-inner {
   color: var(--dark-text-primary);
   background: rgba(1, 26, 48, 0.8);
  }
  
  .keyword-tag:hover .keyword-inner {
   background: rgba(255, 255, 255, 0.95);
   color: var(--secondary-accent);
   transform: translateY(-1px);
  }
  
  .dark .keyword-tag:hover .keyword-inner {
   background: rgba(1, 26, 48, 0.95);
   color: #3b82f6;
  }
  
  .keyword-glow {
   display: none;
  }
  
  @keyframes fade-slide-in {
   from {
     opacity: 0;
     transform: translateX(-10px);
   }
   to {
     opacity: 1;
     transform: translateX(0);
   }
  }
  
  @keyframes pop-in {
   0% {
     opacity: 0;
     transform: translateY(10px) scale(0.9);
   }
   70% {
     opacity: 1;
     transform: translateY(-3px) scale(1.03);
   }
   100% {
     opacity: 1;
     transform: translateY(0) scale(1);
   }
  }
  
  .movie-sidebar::after {
   content: '';
   position: absolute;
   width: 110%;
   height: 150px;
   background: var(--medium-gradient);
   filter: blur(70px);
   opacity: 0.05;
   border-radius: 100%;
   bottom: -80px;
   left: -5%;
   z-index: -1;
   animation: subtle-pulse 10s infinite ease-in-out;
  }
  
  .dark .movie-sidebar::after {
   background: linear-gradient(135deg, rgba(59, 130, 246, 0.3), rgba(79, 70, 229, 0.3));
   opacity: 0.1;
  }
  
  @keyframes subtle-pulse {
   0%, 100% {
     opacity: 0.05;
     transform: translateY(0);
   }
   50% {
     opacity: 0.08;
     transform: translateY(-20px);
   }
  }
  
  @media (min-width: 1200px) {
   .movie-sidebar {
     max-width: 360px;
   }
  }
</style> 