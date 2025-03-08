<script setup>
import { computed, ref, onMounted } from 'vue'
import { useMovieStore } from "@/vue/stores/movieStore"
import MoviePosterCardMobile from "./MoviePosterCardMobile.vue"
import MovieHeaderInfoMobile from "./MovieHeaderInfoMobile.vue"

const props = defineProps({
  movieSlug: {
    type: String,
    required: true
  }
})

const movieStore = useMovieStore()
const { data: movieData } = movieStore.movieComputed(props.movieSlug)

const scrollPosition = ref(0)
const backgroundPosition = computed(() => {
  return movieData.value?.id === 10 ? '70% 10%' : 'center center'
})

onMounted(() => {
  window.addEventListener('scroll', () => {
    scrollPosition.value = window.scrollY
  })
})

const backgroundStyle = computed(() => {
  if (!movieData.value?.background_url) return {}

  const parallaxOffset = Math.min(scrollPosition.value * 0.8, 205)
  return {
    backgroundImage: `url(${movieData.value.background_url})`,
    transform: `translateY(${parallaxOffset}px) scale(1.1)`,
    transition: 'transform 0.1s ease-out'
  }
})

const gradientStyle = computed(() => {
  const baseColor = movieData.value?.gradient_color || '#1a1a1a'
  return {
    background: `
      linear-gradient(
        180deg,
        ${baseColor}00 0%,
        ${baseColor}80 40%,
        ${baseColor}E6 70%,
        ${baseColor} 100%
      ),
      linear-gradient(
        rgba(0, 0, 0, 0.2) 0%,
        rgba(0, 0, 0, 0.4) 100%
      )
    `
  }
})
</script>

<template>
  <div
      class="sm:hidden min-h-[calc(100vh-56px)] overflow-hidden"
      :style="{ backgroundColor: movieData?.gradient_color }"
  >
    <!-- Hero section with dynamic background -->
    <div class="relative min-h-screen bg-[#032541]">
      <!-- Background image with parallax -->
      <div
          class="absolute inset-0 bg-cover bg-no-repeat h-screen"
          :style="{
            ...backgroundStyle,
            backgroundPosition: backgroundPosition
          }"
      />

      <!-- Gradient overlay -->
      <div
          class="absolute inset-0 z-10"
          :style="gradientStyle"
      />

      <!-- Main content container -->
      <div class="relative z-20 h-full">
        <div class="container mx-auto px-4 pt-12">
          <!-- Poster section -->
          <MoviePosterCardMobile :movie-slug="movieSlug" />

          <!-- Header info section that includes title and action panel -->
          <MovieHeaderInfoMobile :movie-slug="movieSlug" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
:root {
  scroll-behavior: smooth;
}

h2 {
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
}
</style>