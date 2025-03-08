<script setup>
import { ref, computed, onMounted } from 'vue'
import MovieCarousel from '@/vue/components/movies/homepage/MovieCarousel.vue'
import SearchBar from "@/vue/components/movies/homepage/SearchBar.vue"
import { useAuthStore } from "@/vue/stores/authStore"

const searchQuery = ref('')
const trendingMovies = ref([])
const popularMovies = ref([])
const latestMovies = ref([])

const authStore = useAuthStore()

const heroBackgroundStyle = computed(() => ({
  backgroundImage: `url('${'/assets/hero-background.jpg'}')`
}))

const handleSearch = () => {
  console.log('Searching for:', searchQuery.value)
}

const fetchMovies = async () => {
  try {
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
  } catch (error) {
    console.error('Error fetching movies:', error)
    trendingMovies.value = []
    popularMovies.value = []
    latestMovies.value = []
  }
}

onMounted(() => {
  fetchMovies()
})
</script>

<template>
  <div class="antialiased font-SourceProNormal">
    <!-- Hero Section -->
    <div
        class="flex justify-center items-start flex-col h-[357px] text-white antialiased my-auto bg-[0%_0%] bg-cover bg-no-repeat sm:bg-[10%_13%]"
        :style="heroBackgroundStyle"
    >
      <div class="container">
        <h2 class="font-SourceProBold text-[2.3rem] leading-10 sm:text-[3rem]">Welcome</h2>
        <h3 class="font-SourceProSemiBold text-[.9rem] sm:text-2xl sm:mt-1">Millions of movies, TV shows and people to discover. Explore now.</h3>
        <SearchBar @search="handleSearch" v-model="searchQuery" />
      </div>
    </div>

    <div class="container">
      <movie-carousel
          :movies="trendingMovies"
          title="Trending"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false"
          :background-bar="true"
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
      />

      <!-- Insights Section -->
      <div class="relative my-20 overflow-hidden rounded-xl bg-gradient-to-r from-slate-900 to-slate-800">
        <div class="modern-overlay"></div>

        <div class="relative z-10 px-4 py-16">
          <div class="max-w-7xl mx-auto">
            <!-- Header -->
            <div class="text-center mb-16">
              <div class="flex justify-center mb-8">
                <div class="pulse-ring">
                  <svg class="w-10 h-10 text-white" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M12 15.968l7.43 4.242-.983-8.311 6.198-6.193-8.54-1.281L12 0 7.895 4.425l-8.54 1.281 6.198 6.193-.983 8.311z"/>
                  </svg>
                </div>
              </div>
              <h2 class="text-3xl md:text-4xl font-bold text-white mb-6 transform hover:scale-105 transition-transform cursor-default">
                Discover, Discuss, Connect
              </h2>
              <p class="text-white/80 text-lg max-w-2xl mx-auto leading-relaxed">
                Join our vibrant community of movie enthusiasts and TV fans. Share your thoughts, discover new content, and stay updated with the latest in entertainment.
              </p>
            </div>

            <!-- Features Grid -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
              <!-- Community Stats -->
              <div class="bg-white/10 backdrop-blur-lg rounded-2xl p-6 transform hover:scale-105 transition-all duration-300">
                <div class="flex items-center mb-4">
                  <div class="p-3 bg-gradient-to-r from-[#032541] to-[#034275] rounded-lg">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                  </div>
                  <h3 class="ml-4 text-xl font-bold text-white">Active Community</h3>
                </div>
                <p class="text-white/70">Over 100,000 members sharing reviews and discussions daily</p>
              </div>

              <!-- Reviews -->
              <div class="bg-white/10 backdrop-blur-lg rounded-2xl p-6 transform hover:scale-105 transition-all duration-300">
                <div class="flex items-center mb-4">
                  <div class="p-3 bg-gradient-to-r from-[#032541] to-[#034275] rounded-lg">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                    </svg>
                  </div>
                  <h3 class="ml-4 text-xl font-bold text-white">Trusted Reviews</h3>
                </div>
                <p class="text-white/70">Millions of verified reviews to help you choose your next watch</p>
              </div>

              <!-- Updates -->
              <div class="bg-white/10 backdrop-blur-lg rounded-2xl p-6 transform hover:scale-105 transition-all duration-300">
                <div class="flex items-center mb-4">
                  <div class="p-3 bg-gradient-to-r from-[#032541] to-[#034275] rounded-lg">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                    </svg>
                  </div>
                  <h3 class="ml-4 text-xl font-bold text-white">Real-time Updates</h3>
                </div>
                <p class="text-white/70">Stay informed with instant notifications about your favorite shows</p>
              </div>
            </div>

            <div class="text-center">
              <a href="#" class="inline-flex items-center px-8 py-3 rounded-full bg-gradient-to-r from-[#032541] to-[#034275] text-white font-semibold transform hover:scale-105 transition-all duration-300 border border-white/20">
                <router-link
                    :to="{ name: authStore.user ? 'discovery' : 'register' }"
                    class="your-existing-classes"
                >
                  {{ authStore.user ? 'Discover Movies' : 'Join CinEmad' }}
                </router-link>
                <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3" />
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>


      <movie-carousel
          :movies="latestMovies"
          title="Latest"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false"
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
  animation: pulse-ring 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
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
</style>