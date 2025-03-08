<script setup>
import MovieHeaderDesktop from "./MovieHeaderDesktop.vue"
import MovieHeaderMobile from "./MovieHeaderMobile.vue"
import { computed } from "vue"
import { useRoute } from "vue-router"

const route = useRoute()

const movieSlug = computed(() => {
  const slug = route.params.slug
  return slug
})
</script>

<template>
  <div class="font-SourceProNormal antialiased">
    <div class="sm:hidden">
      <MovieHeaderMobile :movie-slug="movieSlug" />
    </div>
    <div class="hidden sm:block">
      <MovieHeaderDesktop :movie-slug="movieSlug" />
    </div>
  </div>
</template>