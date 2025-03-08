<template>
  <div class="w-4/5">
    <div class="flex flex-wrap items-center justify-center gap-6">
      <template v-if="loading">
        <MovieCardSkeleton v-for="n in 12" :key="n" />
      </template>
      <template v-else>
        <template v-if="movies.length">
          <MovieCard
              v-for="movie in movies"
              :key="movie.slug"
              :movie="movie"
          />
        </template>
        <NoResults v-else />
      </template>
    </div>
  </div>
</template>

<script setup>
import MovieCard from './MovieCard.vue'
import MovieCardSkeleton from './MovieCardSkeleton.vue'
import NoResults from './NoResults.vue'

defineProps({
  movies: {
    type: Array,
    default: () => []
  },
  loading: {
    type: Boolean,
    default: false
  }
})
</script>