<script setup>
import { inject, computed } from 'vue'
import MoviePosterCard from "./MoviePosterCard.vue"
import MovieHeaderInfo from "./MovieHeaderInfo.vue"

const movieData = inject('movieData')
const backgroundStyle = computed(() => {
  if (!movieData.value?.background_url) return {}
  return {
    backgroundImage: `url(${movieData.value.background_url})`
  }
})

const gradientStyle = computed(() => {
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
    <div
        class="h-full"
        :style="gradientStyle"
    >
      <div class="container h-full min-h-[570px]">
        <div class="flex justify-start items-center gap-6 lg:gap-10 h-full py-4 px-2 md:py-[30px] md:px-0">
          <MoviePosterCard />
          <MovieHeaderInfo />
        </div>
      </div>
    </div>
  </div>
</template>