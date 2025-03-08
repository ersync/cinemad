<template>
  <div class="container">
    <ListHeader
        title="My Favorites"
        :show-count="true"
        :items-count="favorites.length"
        :filter-options="[ 'Title', 'Rating' , 'Date Added', 'Release Date']"
        @filter-change="handleFilterChange"
        @order-change="handleOrderChange"
    />

    <div v-if="isLoading" class="mt-4">
      <p>Loading favorites...</p>
    </div>
    <div v-else-if="error" class="mt-4 text-red-600">
      <p>{{ error }}</p>
    </div>
    <div v-else-if="!favorites.length" class="mt-4">
      <p>You haven't added any movies to your favorites.</p>
    </div>
    <div v-else>
      <MovieListCard
          v-for="movie in sortedMovies"
          :key="movie.id"
          :movie="movie"
      />
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

// Get favorites directly from the store
const favoritesData = interactionStore.listComputed('favorites')
const favorites = favoritesData.movies
const isLoading = favoritesData.isLoading
const error = favoritesData.error

// Use the sorting composable with the computed favorites
const { sortedMovies, handleFilterChange, handleOrderChange } = useSortedMovies(favorites)

// Refresh favorites if needed
const refreshFavorites = () => {
  if (userProfile.value) {
    interactionStore.fetchUserList('favorites', 1, userProfile.value.username)
  }
}

// Watch for username changes in the route to refresh data if needed
watch(() => route.params.username, (newUsername) => {
  if (newUsername && userProfile.value && newUsername !== userProfile.value.username) {
    refreshFavorites()
  }
})

onMounted(() => {
  // If the data hasn't been loaded yet, load it
  if (favorites.value.length === 0 && !isLoading.value) {
    refreshFavorites()
  }
})
</script>