<script setup>
import MovieHeaderDesktop from "./MovieHeaderDesktop.vue"
import MovieHeaderMobile from "./MovieHeaderMobile.vue"

</script>

<template>
  <div class="font-SourceProNormal antialiased">
    <div class="sm:hidden">
      <MovieHeaderMobile />
    </div>
    <div class="hidden sm:block">
      <MovieHeaderDesktop />
    </div>
  </div>
</template>