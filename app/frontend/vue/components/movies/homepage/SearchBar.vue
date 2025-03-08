<template>
  <div class="relative w-full search-container">
    <form @submit.prevent="handleSearch" class="w-full flex mt-[50px]">
      <div class="relative flex w-full">
        <div class="absolute z-10 left-4 top-1/2 -translate-y-1/2 text-gray-400">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </div>

        <input
            v-model="searchQuery"
            @input="handleInput"
            class="h-[40px] sm:h-[50px] py-2 sm:py-2.5 pl-12 pr-4 rounded-l-full bg-white/10 w-full outline-none
                 text-white text-xs sm:text-base placeholder-gray-400 backdrop-blur-sm border border-white/20
                 focus:border-white/40 transition-all duration-300"
            type="text"
            placeholder="Search for movies..."
        >
        <button
            class="h-[40px] sm:h-[50px] -ml-0.5 z-10 px-4 sm:px-8 rounded-r-full font-semibold text-xs sm:text-base
           text-white transition-all duration-300 hover:opacity-90 hover:shadow-lg border border-white/20
           hover:border-white/40"
            :style="gradientStyle"
        >
          Search
        </button>
      </div>
    </form>

    <div
        v-if="showResults && searchResults.length > 0"
        class="absolute w-full bg-[#1a1a1a] mt-2 rounded-xl shadow-2xl z-50 max-h-[400px]
             overflow-y-auto border border-white/10 backdrop-blur-lg"
    >
      <div
          v-for="movie in searchResults"
          :key="movie.id"
          class="p-4 hover:bg-white/5 cursor-pointer transition-all duration-200
               border-b border-white/5 last:border-b-0"
          @click="goToMovie(movie.slug)"
      >
        <div class="flex items-center gap-4">
          <div class="w-12 h-16 rounded-md overflow-hidden flex-shrink-0">
            <img
                :src="movie.cover_url"
                class="w-full h-full object-cover"
                v-if="movie.cover_url"
                :alt="movie.title"
            >
            <div
                v-else
                class="w-full h-full bg-gray-800 flex items-center justify-center text-gray-600"
            >
              No Image
            </div>
          </div>

          <div class="flex-grow">
            <h3 class="text-white font-medium text-base mb-1">{{ movie.title }}</h3>
            <div class="flex items-center gap-3">
              <span class="text-sm text-gray-400">{{ formatDate(movie.release_date) }}</span>
              <span v-if="movie.average_rating" class="flex items-center text-sm text-yellow-400">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                </svg>
                {{ movie.average_rating.toFixed(1) }}
              </span>
            </div>
            <p v-if="movie.overview" class="text-gray-400 text-sm mt-1 line-clamp-1">
              {{ movie.overview }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { movieApiService } from '@/services/movieApiService'

const router = useRouter()
const searchQuery = ref('')
const searchResults = ref([])
const showResults = ref(false)
let searchTimeout = null

const handleInput = async () => {
  if (searchTimeout) clearTimeout(searchTimeout)

  if (searchQuery.value.length > 2) {
    searchTimeout = setTimeout(async () => {
      try {
        const response = await movieApiService.searchMovies(searchQuery.value)

        if (response.success) {
          if (Array.isArray(response.results)) {
            searchResults.value = response.results
          } else if (response.results && Array.isArray(response.results.results)) {
            searchResults.value = response.results.results
          } else {
            searchResults.value = []
          }
        } else {
          searchResults.value = []
        }

        showResults.value = true
      } catch (error) {
        searchResults.value = []
      }
    }, 300)
  } else {
    searchResults.value = []
    showResults.value = false
  }
}

const handleSearch = () => {
  if (searchQuery.value) {
    router.push({
      name: 'search-results',
      query: { q: searchQuery.value }
    })
    showResults.value = false
  }
}

const goToMovie = (slug) => {
  router.push(`/movies/${slug}`)
  searchQuery.value = ''
  showResults.value = false
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

const handleClickOutside = (event) => {
  if (!event.target.closest('.search-container')) {
    showResults.value = false
  }
}

const gradientStyle = {
  background: 'linear-gradient(to right, #032541, #034275, #032541)'
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>

<style scoped>
.overflow-y-auto {
  scrollbar-width: thin;
  scrollbar-color: rgba(255, 255, 255, 0.1) transparent;
}

.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: transparent;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 20px;
}
</style>