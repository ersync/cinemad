<script setup>
import { ref, watch, computed, onMounted, watchEffect } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import { useAuthStore } from '@/vue/stores/authStore'

import MovieHeader from '@/vue/components/movies/show/MovieHeader.vue'
import MovieCastSection from "@/vue/components/movies/show/MovieCastSection.vue"
import MovieReviewSection from "@/vue/components/movies/show/MovieReviewSection.vue"
import MovieRecommendations from "@/vue/components/movies/show/MovieRecommendations.vue"
import MovieMedia from "@/vue/components/movies/show/MovieMedia.vue"
import MovieAdditionalInfo from "@/vue/components/movies/show/MovieAdditionalInfo.vue"
import MovieShowSkeleton from '@/vue/components/movies/show/MovieShowSkeleton.vue'

const route = useRoute()
const movieStore = useMovieStore()
const interactionStore = useUserInteractionStore()
const authStore = useAuthStore()

const slug = computed(() => String(route.params.slug))
const { 
  data: movieData, 
  isLoading, 
  error,
  reviewSection,
  reviews
} = movieStore.movieComputed(slug.value)

watchEffect(() => {
  if (movieData.value?.title) {
    const year = movieData.value.release_date ? new Date(movieData.value.release_date).getFullYear() : ''
    document.title = `${movieData.value.title}${year ? ` (${year})` : ''} - Cinemad`
  } else if (!isLoading.value) {
    document.title = 'Cinemad'
  }
})

const updateInteractionStore = (movie) => {
  if (movie && movie.average_rating) {
    interactionStore.updateMovieAverageRating(slug.value, movie.average_rating)
  }
}

const fetchMovieData = async (newSlug) => {
  try {
    console.log('Fetching movie data for:', newSlug)
    const movieResponse = await movieStore.fetchMovie(newSlug)

    if (movieResponse && movieResponse.average_rating) {
      interactionStore.updateMovieAverageRating(newSlug, movieResponse.average_rating)
    }

    const [
      castData, 
      recommendationsData, 
      reviewSectionData,
      reviewsData,
      mediaVideos, 
      mediaBackdrops, 
      mediaPosters, 
      interactionsData
    ] = await Promise.all([
      movieStore.fetchCast(newSlug),
      movieStore.fetchRecommendations(newSlug),
      movieStore.fetchReviewSection(newSlug),
      movieStore.fetchReviews(newSlug, 1, 5),
      movieStore.fetchMedia(newSlug, 'videos'),
      movieStore.fetchMedia(newSlug, 'backdrops'),
      movieStore.fetchMedia(newSlug, 'posters'),
      authStore.isAuthenticated ? interactionStore.fetchInteractions(newSlug) : Promise.resolve(null)
    ])
    
  } catch (err) {
    console.error('Error fetching movie data:', err)
  }
}

watch(
  () => route.params.slug,
  async (newSlug) => {
    if (newSlug) {
      await fetchMovieData(String(newSlug))
      window.scrollTo({ top: 0, behavior: 'instant' })
    }
  },
  { immediate: true }
)

watch(() => movieData.value, (newMovieData) => {
  if (newMovieData) {
    updateInteractionStore(newMovieData)
  }
}, { immediate: true })

onMounted(() => {
  if (movieData.value) {
    updateInteractionStore(movieData.value)
  }
})
</script>

<template>
  <div class="movie-show">
    <!-- Loading State -->
    <MovieShowSkeleton v-if="isLoading" class="hidden sm:Block" />

    <!-- Error State -->
    <div v-else-if="error" class="container py-8 text-center">
      <p class="text-red-500">{{ error }}</p>
    </div>

    <!-- Content State -->
    <div v-else-if="movieData" class="fade-in">
      <MovieHeader class="min-h-[570px]" />

      <div class="container">
        <div class="flex flex-col lg:flex-row gap-x-3.5 lg:gap-x-1 mt-5 sm:mt-8 mb-2">
          <!-- Left Side -->
          <div class="font-SourceProNormal overflow-hidden px-2">
            <MovieCastSection />
            <MovieReviewSection />
            <MovieMedia />
            <MovieRecommendations />
          </div>

          <!-- Right Side -->
          <div class="min-w-[295px] mx-auto pt-0 mb-5 lg:mx-5">
            <MovieAdditionalInfo />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.fade-in {
  animation: fadeIn 0.3s ease-in;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.container {
  @apply max-w-[1300px] mx-auto px-4;
}

.animate-pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: .7; }
}
</style>