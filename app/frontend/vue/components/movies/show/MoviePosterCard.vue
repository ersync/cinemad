<script setup>
import { inject } from 'vue'

const movieData = inject('movieData')
</script>

<template>
  <div class="flex flex-col shrink-0 w-[240px] md:w-[300px] h-[420px] md:h-[510px] rounded-lg overflow-hidden">
    <!-- Poster with expand overlay -->
    <div class="relative grow group cursor-pointer">
      <div class="absolute inset-0 hover:bg-black/70 transition-all duration-300 hover:backdrop-blur-[20px]">
        <div class="flex justify-center items-center gap-1.5 h-full invisible group-hover:visible">
          <svg class="w-[1.3rem] h-[1.3rem]">
            <use xlink:href="#expand"></use>
          </svg>
          <p class="hover:text-white/70 text-[1.3rem]">Expand</p>
        </div>
      </div>
      <!-- Movie Poster Image -->
      <img
          v-if="movieData?.cover_url"
          :src="movieData.cover_url"
          :alt="movieData.title"
          class="w-full h-full object-cover"
      />
      <div v-else class="w-full h-full bg-gray-700">
        No Image Available
      </div>
    </div>

    <!-- Streaming info -->
    <div class="flex justify-center items-center gap-3 h-[60px] bg-tmdbDarkBlue">
      <div class="w-9 h-9">
        <img src="https://www.themoviedb.org/t/p/original/t2yyOv40HZeVlLjYsCsPHnWLk4W.jpg" alt="">
      </div>
      <div>
        <h4 class="text-white/80 leading-4">Now Streaming</h4>
        <h3 class="font-SourceProSemiBold leading-4">Watch Now</h3>
      </div>
    </div>
  </div>
</template>