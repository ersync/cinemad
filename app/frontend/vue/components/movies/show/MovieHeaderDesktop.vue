<script setup>
import { computed } from 'vue'
import { useMovieStore } from '@/vue/stores/movieStore'
import { useRoute } from "vue-router"
import MoviePosterCardDesktop from './MoviePosterCardDesktop.vue'
import MovieHeaderInfoDesktop from './MovieHeaderInfoDesktop.vue'

const route = useRoute()

const movieStore = useMovieStore()
const movieComputed = movieStore.movieComputed(route.params.slug)
const { data: movieData, isLoading, isComplete } = movieComputed

if (!isComplete.value) {
  movieStore.fetchMovie(route.params.slug)
}

const backgroundStyle = computed(() => {
  if (isLoading.value || !movieData.value?.background_url) {
    return {}
  }
  return {
    backgroundImage: `url(${movieData.value.background_url})`
  }
})

const gradientStyle = computed(() => {
  if (isLoading.value) return {}

  const baseColor = movieData.value?.gradient_color

  if (!baseColor) {
    return {
      backgroundImage: 'linear-gradient(to right, rgba(31.5, 31.5, 31.5, 1) calc((50vw - 170px) - 340px), rgba(31.5, 31.5, 31.5, 0.84) 50%, rgba(31.5, 31.5, 31.5, 0.84) 100%)'
    }
  }

  const desktopColor = baseColor + 'd6'
  return {
    backgroundImage: `linear-gradient(to right, ${baseColor} calc(50vw - 170px - 340px), ${desktopColor} 50%, ${desktopColor} 100%)`
  }
})
</script>

<template>
  <div
      class="min-h-[570px] bg-cover bg-no-repeat header-bg-position text-white"
      :style="backgroundStyle"
  >
    <div class="h-full" :style="gradientStyle">
      <div class="container h-full min-h-[570px]">
        <div v-if="!isLoading && movieData" class="flex justify-start items-center gap-6 lg:gap-10 h-full py-4 px-2 md:py-[30px] md:px-0">
          <MoviePosterCardDesktop />
          <MovieHeaderInfoDesktop />
        </div>
        <div v-else class="flex items-center justify-center h-full">
          <div class="animate-pulse">Loading...</div>
        </div>
      </div>
    </div>
  </div>
</template>