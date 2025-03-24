<template>
  <div
	v-if="visible"
	class="bg-[#1a1a1a] rounded-xl shadow-2xl z-50 max-h-[400px] overflow-y-auto border border-white/10 backdrop-blur-lg"
	:class="containerClass"
  >
	<div v-if="isLoading" class="p-4 text-center text-gray-400">
	  <div class="flex item-center justify-center gap-2">
		<svg class="animate-spin w-5 h-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
		  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
		  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
		</svg>
	    <span class="-mt-[3px]">Searching...</span>
	  </div>
	  
	</div>
	
	<template v-else-if="results.length > 0">
	  <div
		v-for="movie in results"
		:key="movie.id"
		class="p-3 sm:p-4 hover:bg-white/5 cursor-pointer transition-all duration-200 border-b border-white/5 last:border-b-0"
		@click="selectMovie(movie.slug)"
	  >
		<div class="flex items-start gap-3 sm:gap-4">
		  <div class="w-10 h-14 sm:w-12 sm:h-16 rounded-md overflow-hidden flex-shrink-0">
			<img
			  :src="movie.cover_url"
			  class="w-full h-full object-cover"
			  v-if="movie.cover_url"
			  :alt="movie.title"
			>
			<div
			  v-else
			  class="w-full h-full bg-gray-800 flex items-center justify-center text-gray-600 text-xs sm:text-sm"
			>
			  No Image
			</div>
		  </div>
	
		  <div class="flex-grow min-w-0">
			<h3 class="text-white font-medium text-sm sm:text-base mb-1 truncate">{{ movie.title }}</h3>
			<div class="flex flex-wrap items-center gap-2 sm:gap-3">
			  <span class="text-xs sm:text-sm text-gray-400">{{ formatDate(movie.release_date) }}</span>
			  <span v-if="movie.average_rating" class="flex items-center text-xs sm:text-sm text-yellow-400">
				<svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 sm:h-4 sm:w-4 mr-0.5 sm:mr-1" viewBox="0 0 20 20" fill="currentColor">
				  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
				</svg>
				{{ movie.average_rating.toFixed(1) }}
			  </span>
			</div>
			<p v-if="movie.overview" class="text-gray-400 text-xs sm:text-sm mt-1 line-clamp-1">
			  {{ movie.overview }}
			</p>
		  </div>
		</div>
	  </div>
	</template>
	
	<div v-else-if="query && query.length >= 3" class="p-4 text-center text-gray-400">
	  No results found
	</div>
	
	<div v-else class="p-4 text-center text-gray-400">
	  Please enter at least 3 characters to search
	</div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import { useRouter } from 'vue-router'
import { movieApiService } from '@/services/movieApiService'

const props = defineProps({
  query: {
	type: String,
	default: ''
  },
  visible: {
	type: Boolean,
	default: false
  },
  containerClass: {
	type: String,
	default: ''
  },
  isMobile: {
	type: Boolean,
	default: false
  }
})

const emit = defineEmits(['select'])

const router = useRouter()
const results = ref([])
const isLoading = ref(false)
let searchTimeout = null

watch(() => props.query, (newQuery) => {
  if (newQuery && newQuery.length >= 3) {
	performSearch(newQuery)
  } else {
	results.value = []
  }
}, { immediate: true })

const performSearch = (query) => {
  if (searchTimeout) clearTimeout(searchTimeout)
  
  searchTimeout = setTimeout(async () => {
	isLoading.value = true
	
	try {
	  const response = await movieApiService.searchMovies(query)
	  
	  if (response.success) {
		if (Array.isArray(response.results)) {
		  results.value = response.results
		} else if (response.results && Array.isArray(response.results.results)) {
		  results.value = response.results.results
		} else {
		  results.value = []
		}
	  } else {
		results.value = []
	  }
	} catch (error) {
	  console.error('Search error:', error)
	  results.value = []
	} finally {
	  isLoading.value = false
	}
  }, 300)
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

const selectMovie = (slug) => {
  emit('select', slug)
  
  if (props.isMobile) {
	router.push(`/movies/${slug}`)
  }
}
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