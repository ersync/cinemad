<template>
  <div class="container">
    <ListHeader
        title="My Favorites"
        :show-count="true"
        :items-count="favoritesTotalCount"
        :filter-options="['Title', 'Rating', 'Date Added', 'Release Date']"
        @filter-change="handleFilterChange"
        @order-change="handleOrderChange"
    />

    <div v-if="isLoading" class="mt-4">
      <MovieListCardSkeleton v-for="n in 3" :key="n" />
    </div>
    <div v-else-if="error" class="mt-4 text-red-600">
      <p>{{ error }}</p>
    </div>
    <div v-else-if="!favorites.length" class="mt-4">
      <p>You haven't added any movies to your favorites.</p>
    </div>
    <div v-else>
      <MovieListCard
          v-for="movie in favorites"
          :key="movie.id"
          :movie="movie"
      />
    </div>

    <div v-if="favorites.length > 0 || favoritesTotalCount > 0" class="mt-4 flex justify-center">
      <Pagination
          :current-page="currentPage"
          :total-pages="totalPages"
          @page-change="handlePageChange"
      />
    </div>

  </div>
</template>

<script setup>
import { computed, onMounted, watch, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import { useAuthStore } from '@/vue/stores/authStore'
import ListHeader from '@/vue/components/user/ListHeader.vue'
import MovieListCard from '@/vue/components/user/MovieListCard.vue'
import Pagination from '@/vue/components/user/Pagination.vue'
import { useSortedMovies } from '@/vue/composables/useSortedMovies'
import MovieListCardSkeleton from "@/vue/components/user/MovieListCardSkeleton.vue"

const route = useRoute()
const router = useRouter()
const interactionStore = useUserInteractionStore()
const authStore = useAuthStore()

const currentPage = computed(() => {
  const page = parseInt(route.query.page) || 1
  return page > 0 ? page : 1
})

const username = computed(() => {
  return route.params.username || authStore.user?.username
})

const favoritesData = interactionStore.listComputed('favorites')
const favorites = favoritesData.movies
const isLoading = favoritesData.isLoading
const error = favoritesData.error

const favoritesTotalCount = computed(() => {
  return favoritesData.meta.value?.total_count || 0
})

const totalPages = computed(() => {
  return favoritesData.meta.value?.total_pages || 1
})

// TODO: the sorting logic should be refactored. Currently it's not getting used..
const { sortedMovies, handleFilterChange, handleOrderChange } = useSortedMovies(favorites)

const handlePageChange = (page) => {
  router.push({
    query: { ...route.query, page }
  })
  interactionStore.fetchUserList('favorites', page, username.value)

}


watch(() => authStore.isAuthenticated, (isAuthenticated) => {
  if (isAuthenticated && username.value) {
    interactionStore.fetchUserList('favorites', currentPage.value, username.value)
  }
})

</script>