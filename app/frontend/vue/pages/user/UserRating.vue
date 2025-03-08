<template>
  <div class="container">
    <ListHeader
        title="My Ratings"
        :show-count="true"
        :items-count="movies.length"
        :filter-options="[ 'Title', 'Rating' , 'Date Added', 'Release Date']"
        @filter-change="handleFilterChange"
        @order-change="handleOrderChange"
    />

    <div v-if="isLoading" class="mt-4 text-center">
      <p>Loading ratings...</p>
    </div>
    <div v-else-if="error" class="mt-4 text-center text-red-600">
      <p>{{ error }}</p>
    </div>
    <div v-else-if="!movies.length" class="mt-4 text-center py-8 text-gray-500">
      <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 15h2m-2-4h2m-6-4h10a2 2 0 012 2v10a2 2 0 01-2 2H7a2 2 0 01-2-2V7a2 2 0 012-2z" />
      </svg>
      <p class="text-lg font-medium">You haven't rated any movies yet</p>
      <p class="mt-2">Rate movies to keep track of your opinions and help others discover great films</p>
    </div>

    <div v-else>
      <div class="space-y-4 mt-6">
        <MovieListCard
            v-for="movie in sortedMovies"
            :key="movie.id"
            :movie="movie"
        />
      </div>

      <div class="text-center text-sm text-gray-500 mt-4">
        Total pages: {{ meta.totalPages }} | Current page: {{ meta.currentPage }} | Total movies: {{ meta.totalCount }}
      </div>

      <!-- Pagination -->
      <div v-if="meta.totalPages > 1" class="mt-8 flex justify-center gap-2">
        <button
            v-for="page in meta.totalPages"
            :key="page"
            @click="handlePageChange(page)"
            class="px-4 py-2 rounded-lg transition-colors"
            :class="[
              page === meta.currentPage
                ? 'bg-blue-500 text-white'
                : 'bg-gray-100 hover:bg-gray-200'
            ]"
        >
          {{ page }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import ListHeader from '@/vue/components/user/ListHeader.vue'
import MovieListCard from '@/vue/components/user/MovieListCard.vue'
import { useSortedMovies } from '@/vue/composables/useSortedMovies'

const route = useRoute()
const interactionStore = useUserInteractionStore()

// Get user profile from the store
const userProfile = computed(() => interactionStore.userProfileComputed)

// Get ratings data from store
const ratingsData = interactionStore.listComputed('ratings')
const movies = ratingsData.movies
const meta = ratingsData.meta
const isLoading = ratingsData.isLoading
const error = ratingsData.error

// Use the sorting composable with the store's movies
const { sortedMovies, handleFilterChange, handleOrderChange } = useSortedMovies(movies)

// Handle page changes
const handlePageChange = async (page) => {
  if (userProfile.value) {
    await interactionStore.fetchUserList('ratings', page, userProfile.value.username)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

// Refresh ratings if needed
const refreshRatings = () => {
  if (userProfile.value) {
    interactionStore.fetchUserList('ratings', 1, userProfile.value.username)
  }
}

// Watch for username changes in the route to refresh data if needed
watch(() => route.params.username, (newUsername) => {
  if (newUsername && userProfile.value && newUsername !== userProfile.value.username) {
    refreshRatings()
  }
})

onMounted(() => {
  // If the data hasn't been loaded yet, load it
  if (movies.value.length === 0 && !isLoading.value) {
    refreshRatings()
  }
})
</script>