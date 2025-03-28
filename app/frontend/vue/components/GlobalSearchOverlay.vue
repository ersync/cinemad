<template>
  <Transition name="modal-fade">
    <div 
      v-if="isOpen"
      class="fixed inset-0 bg-black/90 backdrop-blur-md z-[100] flex items-start justify-center pt-[12vh] px-4"
      @click="handleOverlayClick"
    >
      <div class="w-full max-w-2xl">
        <!-- Search Container -->
        <div class="relative" @click.stop>
          <!-- Search Input -->
          <input
            ref="searchInput"
            v-model="searchQuery"
            @input="handleInput"
            class="w-full h-16 bg-gray-900/80 text-white text-lg px-6 pl-14
                 rounded-xl border border-gray-600/50 focus:border-blue-400/60
                 outline-none backdrop-blur-sm transition-all duration-200
                 placeholder-gray-400 shadow-lg"
            type="text"
            placeholder="Search for movies..."
          >

          <!-- Search Icon -->
          <div class="absolute left-5 top-1/2 -translate-y-1/2 text-gray-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
          </div>

          <!-- Close Button -->
          <button
            @click="close"
            class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-300 hover:text-white transition-colors duration-150"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <!-- Results Section -->
        <div class="mt-4" @click.stop>
          <!-- Loading State -->
          <div v-if="isLoading" class="text-center py-8">
            <div class="inline-flex items-center gap-2 text-gray-400">
              <svg class="animate-spin w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              <span>Searching...</span>
            </div>
          </div>

          <!-- Results List -->
          <div 
            v-else-if="showResults && searchResults.length > 0"
            class="bg-gray-900/80 backdrop-blur-md rounded-xl border border-gray-700/50 overflow-hidden max-h-[60vh] overflow-y-auto shadow-xl"
          >
            <div 
              v-for="movie in searchResults"
              :key="movie.id"
              @click="goToMovie(movie.slug)"
              class="group flex items-center gap-4 p-4 hover:bg-gray-800/60 cursor-pointer transition-colors duration-150 border-b border-gray-800 last:border-b-0"
            >
              <!-- Movie Poster -->
              <div class="w-12 h-16 rounded-lg overflow-hidden flex-shrink-0 bg-gray-800/50">
                <img
                  v-if="movie.cover_url"
                  :src="movie.cover_url"
                  :alt="movie.title"
                  class="w-full h-full object-cover"
                >
                <div v-else class="w-full h-full flex items-center justify-center text-gray-500 text-xs">
                  No Image
                </div>
              </div>

              <!-- Movie Info -->
              <div class="flex-grow min-w-0">
                <h3 class="text-white font-medium text-base sm:text-lg truncate">{{ movie.title }}</h3>
                <div class="flex items-center gap-3 mt-1.5">
                  <span class="text-gray-400 text-sm">{{ formatDate(movie.release_date) }}</span>
                  <span v-if="movie.average_rating" class="flex items-center text-sm text-amber-400">
                    <svg class="w-4 h-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    {{ movie.average_rating.toFixed(1) }}
                  </span>
                </div>
              </div>

              <!-- Arrow Icon -->
              <div class="text-gray-500 group-hover:text-blue-400 transition-colors duration-200">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                </svg>
              </div>
            </div>
          </div>

          <!-- No Results Message -->
          <div 
            v-else-if="searchQuery.length >= 3 && !isLoading && searchPerformed && searchResults.length === 0"
            class="text-center py-8 text-gray-400"
          >
            No results found for "{{ searchQuery }}"
          </div>

          <!-- Initial State Message -->
          <div 
            v-else-if="searchQuery.length > 0 && searchQuery.length < 3"
            class="text-center py-8 text-gray-400"
          >
            Please enter at least 3 characters to search
          </div>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { movieApiService } from '@/services/movieApiService'

const router = useRouter()
const isOpen = ref(false)
const searchQuery = ref('')
const searchResults = ref([])
const showResults = ref(false)
const searchInput = ref(null)
const isLoading = ref(false)
const searchPerformed = ref(false)
let searchTimeout = null

const handleInput = async () => {
  if (searchTimeout) clearTimeout(searchTimeout)

  if (searchQuery.value.length > 2) {
    isLoading.value = true
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
        searchPerformed.value = true
      } catch (error) {
        searchResults.value = []
      } finally {
        isLoading.value = false
      }
    }, 300)
  } else {
    searchResults.value = []
    showResults.value = false
    searchPerformed.value = false
  }
}

const handleOverlayClick = (event) => {
  if (event.target === event.currentTarget) {
    close()
  }
}

const goToMovie = async (slug) => {
  try {
    close()

    await new Promise(resolve => setTimeout(resolve, 100))

    const currentRoute = router.currentRoute.value

    if (currentRoute.name === 'movie-show') {
      window.location.href = `/movies/${slug}`
      return
    }

    await router.push({
      name: 'movie-show',
      params: { slug: slug }
    })
  } catch (error) {
    window.location.href = `/movies/${slug}`
  }
}

const close = () => {
  isOpen.value = false
  searchQuery.value = ''
  searchResults.value = []
  showResults.value = false
  searchPerformed.value = false
}

const handleEscape = (e) => {
  if (e.key === 'Escape' && isOpen.value) {
    close()
  }
}

const handleToggleSearch = () => {
  isOpen.value = !isOpen.value
  if (isOpen.value) {
    setTimeout(() => {
      searchInput.value?.focus()
    }, 100)
  }
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

onMounted(() => {
  window.addEventListener('toggleGlobalSearch', handleToggleSearch)
  document.addEventListener('keydown', handleEscape)
})

onUnmounted(() => {
  window.removeEventListener('toggleGlobalSearch', handleToggleSearch)
  document.removeEventListener('keydown', handleEscape)
})
</script>

<style scoped>
.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

.overflow-y-auto {
  scrollbar-width: thin;
  scrollbar-color: rgba(255, 255, 255, 0.15) transparent;
}

::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

::-webkit-scrollbar-track {
  background: transparent;
}

::-webkit-scrollbar-thumb {
  background-color: rgba(255, 255, 255, 0.15);
  border-radius: 3px;
}
</style>