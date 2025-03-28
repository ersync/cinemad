<script setup>
import { ref, computed, onMounted } from 'vue'
import MovieCarousel from '@/vue/components/movies/homepage/MovieCarousel.vue'
import SearchBar from "@/vue/components/movies/homepage/SearchBar.vue"
import { useAuthStore } from "@/vue/stores/authStore"
import heroBackground from '@/assets/images/hero-background.jpg'

const searchQuery = ref('')
const trendingMovies = ref([])
const popularMovies = ref([])
const latestMovies = ref([])
const isLoadingTrending = ref(true)
const isLoadingPopular = ref(true)
const isLoadingLatest = ref(true)

const authStore = useAuthStore()

const heroBackgroundStyle = computed(() => ({
  backgroundImage: `url('${heroBackground}')`
}))

const handleSearch = () => {
}

const fetchMovies = async () => {
  try {
    isLoadingTrending.value = true
    isLoadingPopular.value = true
    isLoadingLatest.value = true
    
    const response = await fetch('/api/movies/home_page', {
      headers: {
        'Accept': 'application/json'
      }
    })

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }

    const data = await response.json()

    if (!data.success) {
      throw new Error(data.errors?.[0] || 'Failed to fetch movies')
    }

    trendingMovies.value = data.sections?.trending || []
    popularMovies.value = data.sections?.popular || []
    latestMovies.value = data.sections?.latest || []
    
    isLoadingTrending.value = false
    isLoadingPopular.value = false
    isLoadingLatest.value = false
  } catch (error) {
    console.error('Error fetching movies:', error)
    trendingMovies.value = []
    popularMovies.value = []
    latestMovies.value = []
    
    isLoadingTrending.value = false
    isLoadingPopular.value = false
    isLoadingLatest.value = false
  }
}

onMounted(() => {
  fetchMovies()
})
</script>

<template>
  <div class="antialiased font-SourceProNormal">
    <div class="relative h-[400px] sm:h-[500px] mb-10 bg-gradient-to-b from-[#010e19]/70 via-[#011a30]/60 to-[#010e19]/90">
      <div 
        class="absolute inset-0 bg-cover bg-top transform scale-105 transition-transform duration-10000 ease-out animate-subtle-zoom"
        :style="heroBackgroundStyle"
      >
        <div class="absolute inset-0 bg-gradient-to-b from-[#010e19]/70 via-[#011a30]/60 to-[#010e19]/90"></div>
        
        <div class="absolute inset-0 opacity-30">
          <div class="particles-container"></div>
        </div>
      </div>
    
      <div class="absolute inset-0 overflow-hidden pointer-events-none">
        <div class="absolute top-[20%] right-[10%] w-32 h-32 rounded-full bg-blue-500/10 blur-3xl animate-float-slow"></div>
        <div class="absolute bottom-[30%] left-[15%] w-40 h-40 rounded-full bg-indigo-500/10 blur-3xl animate-float-slower"></div>
        <div class="absolute top-[40%] left-[25%] w-24 h-24 rounded-full bg-cyan-400/10 blur-2xl animate-float"></div>
      </div>
    
      <div class="relative h-full flex items-center">
        <div class="container mx-auto px-6 md:px-12">
          <div class="max-w-3xl" data-aos="fade-up" data-aos-duration="800">
            <div class="inline-flex items-center px-3 py-1 mb-6 rounded-full bg-white/10 backdrop-blur-md border border-white/20 text-sm text-blue-300 animate-pulse-subtle">
              <span class="w-2 h-2 rounded-full bg-blue-400 mr-2"></span>
              <span>Discover the latest in entertainment</span>
            </div>
            
            <h1 class="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-bold mb-4 tracking-tight">
              <span class="bg-clip-text text-transparent bg-gradient-to-r from-white via-blue-200 to-indigo-200 px-0.5">
                Unlimited Movies & TV
              </span>
            </h1>
            
            <div class="mb-6">
              <h2 class="font-SourceProSemiBold text-base sm:text-2xl text-white/80 leading-relaxed max-w-xl">
                Millions of movies, TV shows and people to discover.
                <span class="relative inline-block">
                  <span class="text-blue-400 font-semibold hidden sm:inline">Explore now.</span>
                  <span class="absolute bottom-0 left-0 w-full h-[1px] sm:h-[2px] bg-blue-400/50"></span>
                </span>
              </h2>
            </div>
            
            <div class="mt-8 relative z-10 transform transition-all duration-500">
              <SearchBar 
                @search="handleSearch" 
                v-model="searchQuery" 
                class="search-glow"
              />
              
              <div class="absolute -right-12 -top-12 w-24 h-24 bg-blue-500/5 rounded-full blur-2xl"></div>
              <div class="absolute -left-8 -bottom-8 w-20 h-20 bg-indigo-500/5 rounded-full blur-2xl"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <movie-carousel
          :movies="trendingMovies"
          title="Trending"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false" 
          :background-bar="true"
          :is-loading="isLoadingTrending"
      />

      <!-- Stats Section -->
      <div class="relative my-20 overflow-hidden rounded-3xl bg-gradient-to-r from-slate-900 to-slate-800">
        <div class="modern-overlay"></div>
        <div class="flex flex-wrap justify-center gap-8 relative z-10 py-12 px-4">
          <div class="stats-card group" data-aos="fade-up" data-aos-delay="100">
            <div class="stats-number">2.4M+</div>
            <div class="stats-label">Verified Reviews</div>
            <div class="card-glow"></div>
          </div>
          <div class="stats-card group" data-aos="fade-up" data-aos-delay="200">
            <div class="stats-number">98K+</div>
            <div class="stats-label">Active Critics</div>
            <div class="card-glow"></div>
          </div>
          <div class="stats-card group" data-aos="fade-up" data-aos-delay="300">
            <div class="stats-number">850+</div>
            <div class="stats-label">New Releases</div>
            <div class="card-glow"></div>
          </div>
        </div>
      </div>

      <movie-carousel
          :movies="popularMovies"
          title="What's Popular"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false"
          :is-loading="isLoadingPopular"
      />

      <!-- Insights Section -->
      <div class="relative my-20 overflow-hidden rounded-2xl bg-gradient-to-r from-[#010e19] via-[#011a30] to-[#010e19]">
        <div class="absolute inset-0 overflow-hidden">
          <div class="absolute -top-20 left-1/4 w-64 h-64 rounded-full bg-blue-500/5 blur-3xl opacity-60"></div>
          <div class="absolute -bottom-20 right-1/3 w-72 h-72 rounded-full bg-indigo-500/5 blur-3xl opacity-50"></div>
          <div class="absolute top-1/3 right-1/4 w-48 h-48 rounded-full bg-cyan-400/5 blur-2xl"></div>
        </div>
        
        <div class="relative z-10 px-4 py-16">
          <div class="max-w-7xl mx-auto">
            <div class="text-center mb-16">
              <div class="flex justify-center mb-8">
                <div class="relative group">
                  <div class="absolute inset-0 bg-blue-500/20 rounded-full blur-xl group-hover:bg-blue-500/30 transition-all duration-500"></div>
                  <div class="relative w-16 h-16 flex items-center justify-center rounded-full bg-gradient-to-br from-blue-600/80 to-indigo-600/80 group-hover:shadow-lg group-hover:shadow-blue-500/20 transition-all duration-300">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
                    </svg>
                  </div>
                </div>
              </div>
              
              <h2 class="text-3xl md:text-4xl font-bold text-white mb-6 transform transition-transform cursor-default">
                <span class="bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-indigo-400">Discover, Discuss, Connect</span>
              </h2>
              
              <p class="text-white/80 text-lg max-w-2xl mx-auto leading-relaxed">
                Join our vibrant community of movie enthusiasts and TV fans. Share your thoughts, discover new content, and stay updated with the latest in entertainment.
              </p>
            </div>
      
            <!-- Features Grid -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
              <div class="relative group">
                <div class="absolute inset-0 bg-gradient-to-r from-blue-600/5 to-indigo-600/5 rounded-2xl blur-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                <div class="relative bg-white/5 backdrop-blur-lg rounded-2xl p-6 border border-white/10 transform hover:translate-y-[-4px] transition-all duration-300">
                  <div class="flex items-center mb-4">
                    <div class="p-3 bg-gradient-to-br from-blue-600/80 to-indigo-600/80 rounded-xl shadow-lg shadow-blue-500/10">
                      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM6.75 9.75a2 2 0 11-4 0 2 2 0 014 0z" />
                      </svg>
                    </div>
                    <h3 class="ml-4 text-xl font-bold text-white">Active Community</h3>
                  </div>
                  <p class="text-white/70">Over 100,000 members sharing reviews and discussions daily</p>
                </div>
              </div>
      
              <!-- Reviews -->
              <div class="relative group">
                <div class="absolute inset-0 bg-gradient-to-r from-blue-600/5 to-indigo-600/5 rounded-2xl blur-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                <div class="relative bg-white/5 backdrop-blur-lg rounded-2xl p-6 border border-white/10 transform hover:translate-y-[-4px] transition-all duration-300">
                  <div class="flex items-center mb-4">
                    <div class="p-3 bg-gradient-to-br from-blue-600/80 to-indigo-600/80 rounded-xl shadow-lg shadow-blue-500/10">
                      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z" />
                      </svg>
                    </div>
                    <h3 class="ml-4 text-xl font-bold text-white">Trusted Reviews</h3>
                  </div>
                  <p class="text-white/70">Millions of verified reviews to help you choose your next watch</p>
                </div>
              </div>
      
              <!-- Updates -->
              <div class="relative group">
                <div class="absolute inset-0 bg-gradient-to-r from-blue-600/5 to-indigo-600/5 rounded-2xl blur-sm opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                <div class="relative bg-white/5 backdrop-blur-lg rounded-2xl p-6 border border-white/10 transform hover:translate-y-[-4px] transition-all duration-300">
                  <div class="flex items-center mb-4">
                    <div class="p-3 bg-gradient-to-br from-blue-600/80 to-indigo-600/80 rounded-xl shadow-lg shadow-blue-500/10">
                      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.75" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
                      </svg>
                    </div>
                    <h3 class="ml-4 text-xl font-bold text-white">Real-time Updates</h3>
                  </div>
                  <p class="text-white/70">Stay informed with instant notifications about your favorite shows</p>
                </div>
              </div>
            </div>
      
            <div class="text-center">
              <router-link
                :to="{ name: authStore.user ? 'discovery' : 'register' }"
                class="group relative overflow-hidden inline-flex items-center px-8 py-3.5 rounded-full bg-gradient-to-r from-blue-600/80 to-indigo-600/80 text-white font-semibold transition-all duration-300 hover:shadow-lg hover:shadow-blue-500/20"
              >
                <div class="absolute inset-0 flex items-center justify-center">
                  <div class="h-[200%] w-[200%] animate-slow-spin rounded-full bg-gradient-to-tr from-blue-500/0 via-blue-500/30 to-blue-500/0 opacity-0 transition-opacity duration-500 group-hover:opacity-100"></div>
                </div>
                <span class="relative flex items-center">
                  {{ authStore.user ? 'Discover Movies' : 'Join CinEmad' }}
                  <svg class="w-5 h-5 ml-2 transition-transform duration-300 group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6" />
                  </svg>
                </span>
              </router-link>
            </div>
          </div>
        </div>
        
        <div class="absolute bottom-0 left-0 right-0 h-[1px] bg-gradient-to-r from-blue-500/0 via-blue-500/20 to-blue-500/0"></div>
      </div>


      <movie-carousel
          :movies="latestMovies"
          title="Latest"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false"
          :is-loading="isLoadingLatest"
      />
    </div>
  </div>
</template>

<style scoped>
.container {
  @apply max-w-[1300px] mx-auto px-4;
}

.stats-card {
  @apply px-8 py-6 rounded-2xl transition-all duration-300 transform hover:-translate-y-1;
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.stats-card:hover {
  background: rgba(255, 255, 255, 0.05);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
}

.stats-number {
  @apply text-4xl font-bold mb-2;
  background: linear-gradient(135deg, #60A5FA, #C084FC);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stats-label {
  @apply text-sm text-gray-300 font-medium;
}

.modern-overlay {
  position: absolute;
  inset: 0;
  background:
      radial-gradient(circle at top right, rgba(99, 102, 241, 0.15), transparent 50%),
      radial-gradient(circle at bottom left, rgba(168, 85, 247, 0.15), transparent 50%);
  pointer-events: none;
}

.card-glow {
  position: absolute;
  inset: 0;
  background: radial-gradient(
      circle at var(--mouse-x, 50%) var(--mouse-y, 50%),
      rgba(255, 255, 255, 0.1) 0%,
      transparent 50%
  );
  opacity: 0;
  transition: opacity 0.3s;
}

.stats-card:hover .card-glow {
  opacity: 1;
}

.modern-section-break {
  @apply relative overflow-hidden;
  background: linear-gradient(
      to right,
      rgba(249, 250, 251, 0.05),
      rgba(249, 250, 251, 0.1),
      rgba(249, 250, 251, 0.05)
  );
}

.pulse-ring {
  @apply relative w-16 h-16 flex items-center justify-center rounded-full;
  background: linear-gradient(45deg, #4F46E5, #7C3AED);
}

.pulse-ring::before {
  content: '';
  position: absolute;
  inset: -4px;
  border-radius: 50%;
  background: inherit;
  opacity: 0.5;
}

@keyframes pulse-ring {
  0% {
    transform: scale(0.8);
    opacity: 0.5;
  }
  100% {
    transform: scale(1.2);
    opacity: 0;
  }
}

@media (max-width: 768px) {
  .stats-card {
    @apply px-6 py-4;
  }

  .stats-number {
    @apply text-2xl;
  }

  .stats-label {
    @apply text-xs;
  }
}

/* Subtle zoom animation */
@keyframes subtle-zoom {
  0% { transform: scale(1.05); }
  50% { transform: scale(1.1); }
  100% { transform: scale(1.05); }
}

.animate-subtle-zoom {
  animation: subtle-zoom 20s infinite ease-in-out;
}

/* Floating animations */
@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-15px); }
  100% { transform: translateY(0px); }
}

@keyframes float-slow {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-20px); }
  100% { transform: translateY(0px); }
}

@keyframes float-slower {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-25px); }
  100% { transform: translateY(0px); }
}

.animate-float {
  animation: float 6s infinite ease-in-out;
}

.animate-float-slow {
  animation: float-slow 8s infinite ease-in-out;
}

.animate-float-slower {
  animation: float-slower 10s infinite ease-in-out;
}

@keyframes pulse-subtle {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.8; }
}

.animate-pulse-subtle {
  animation: pulse-subtle 3s infinite ease-in-out;
}

.search-glow {
  box-shadow: 0 0 20px rgba(59, 130, 246, 0.1);
  transition: all 0.3s ease;
}

.search-glow:hover {
  box-shadow: 0 0 30px rgba(59, 130, 246, 0.2);
}
</style>