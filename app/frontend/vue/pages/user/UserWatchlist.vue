<template>
  <div class="container">
    <ListHeader
        title="My Watchlist"
        :show-count="true"
        :items-count="meta.totalCount"
        :filter-options="filterOptions"
        :current-filter="currentFilter"
        :current-order="currentOrder"
        @filter-change="handleFilterChange"
        @order-change="handleOrderChange"
    />

    <div v-if="isLoading" class="mt-4 text-center">
      <p>Loading watchlist...</p>
    </div>
    <div v-else-if="error" class="mt-4 text-center text-red-600">
      <p>{{ error }}</p>
    </div>
    <div v-else-if="!movies.length" class="mt-4 text-center py-8 text-gray-500">
      <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
      </svg>
      <p class="text-lg font-medium">Your watchlist is empty</p>
      <p class="mt-2">Start adding movies to keep track of what you want to watch</p>
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
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import ListHeader from '@/vue/components/user/ListHeader.vue'
import MovieListCard from '@/vue/components/user/MovieListCard.vue'
import { useSortedMovies } from '@/vue/composables/useSortedMovies'

const route = useRoute()
const interactionStore = useUserInteractionStore()

// Get user profile from the store
const userProfile = computed(() => interactionStore.userProfileComputed)

// Get watchlist data from store
const watchlistData = interactionStore.listComputed('watchlist')
const movies = watchlistData.movies
const meta = watchlistData.meta
const isLoading = watchlistData.isLoading
const error = watchlistData.error

// Sorting/Filtering state
const filterOptions = ['Title', 'Rating', 'Date Added', 'Release Date']
const currentFilter = ref('Title')
const currentOrder = ref('desc')

// Use the sorting composable with the store's movies
const { sortedMovies, handleFilterChange, handleOrderChange } = useSortedMovies(movies)

// Handle page changes
const handlePageChange = async (page) => {
  if (userProfile.value) {
    await interactionStore.fetchUserList('watchlist', page, userProfile.value.username)
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
}

// Refresh watchlist if needed
const refreshWatchlist = () => {
  if (userProfile.value) {
    interactionStore.fetchUserList('watchlist', 1, userProfile.value.username)
  }
}

// Watch for username changes in the route to refresh data if needed
watch(() => route.params.username, (newUsername) => {
  if (newUsername && userProfile.value && newUsername !== userProfile.value.username) {
    refreshWatchlist()
  }
})

onMounted(() => {
  // If the data hasn't been loaded yet, load it
  if (movies.value.length === 0 && !isLoading.value) {
    refreshWatchlist()
  }
})
</script>