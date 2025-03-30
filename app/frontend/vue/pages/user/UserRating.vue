<template>
  <div class="container">
    <ListHeader
        title="My Ratings"
        :show-count="true"
        :items-count="ratingsTotalCount"
        :filter-options="['Title', 'Rating', 'Date Added', 'Release Date']"
        @filter-change="handleFilterChange"
        @order-change="handleOrderChange"
    />

    <div v-if="isLoading" class="mt-4">
      <MovieListCardSkeleton v-for="n in 3" :key="n" />
    </div>
    <div v-else-if="error" class="mt-4 text-red-600 dark:text-red-400">
      <p>{{ error }}</p>
    </div>
    <div v-else-if="!ratings.length" class="mt-4 text-gray-700 dark:text-gray-300">
      <p>You haven't rated any movies yet.</p>
    </div>
    <div v-else>
      <MovieListCard
          v-for="movie in ratings"
          :key="movie.id"
          :movie="movie"
      />
    </div>

    <div v-if="ratings.length > 0 || ratingsTotalCount > 0" class="mt-4 flex justify-center">
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

const ratingsData = interactionStore.listComputed('ratings')
const ratings = ratingsData.movies
const isLoading = ratingsData.isLoading
const error = ratingsData.error

const ratingsTotalCount = computed(() => {
  return ratingsData.meta.value?.total_count || 0
})

const totalPages = computed(() => {
  return ratingsData.meta.value?.total_pages || 1
})

// TODO: the sorting logic should be refactored. Currently it's not getting used..
const { sortedMovies, handleFilterChange, handleOrderChange } = useSortedMovies(ratings)

const handlePageChange = (page) => {
  router.push({
    query: { ...route.query, page }
  })
  interactionStore.fetchUserList('ratings', page, username.value)
}

watch(() => authStore.isAuthenticated, (isAuthenticated) => {
  if (isAuthenticated && username.value) {
    interactionStore.fetchUserList('ratings', currentPage.value, username.value)
  }
})
</script>