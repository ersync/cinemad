<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)
const { data: movieData } = movieStore.movieComputed(movieSlug.value)

const isExpanded = ref(false)

const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}
</script>

<template>
  <div class="relative">
    <!-- Main Card Container -->
    <div class="flex flex-col shrink-0 w-[240px] md:w-[300px] h-[420px] md:h-[510px]
                rounded-lg overflow-hidden transition-all duration-300 transform"
         :class="{ 'scale-105': isExpanded }">
      <!-- Poster with expand overlay -->
      <div class="relative grow group cursor-pointer" @click="toggleExpand">
        <div class="absolute inset-0 transition-all duration-300"
             :class="isExpanded ? 'bg-black/70 backdrop-blur-[20px]' : 'hover:bg-black/70 hover:backdrop-blur-[20px]'">
          <div class="flex justify-center items-center gap-1.5 h-full"
               :class="isExpanded ? 'visible' : 'invisible group-hover:visible'">
            <svg class="w-[1.3rem] h-[1.3rem] text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M4 8h16M4 16h16M8 4l4 4-4 4" />
            </svg>
            <p class="text-white hover:text-white/70 text-[1.3rem]">
              Expand
            </p>
          </div>
        </div>

        <img v-if="movieData?.cover_url"
             :src="movieData.cover_url"
             :alt="movieData.title"
             class="w-full h-full object-cover"
        />
        <div v-else class="w-full h-full bg-gray-700 flex items-center justify-center text-white/50">
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

    <!-- Expanded Modal -->
    <Transition
        enter-active-class="transition ease-out duration-300"
        enter-from-class="opacity-0 scale-95"
        enter-to-class="opacity-100 scale-100"
        leave-active-class="transition ease-in duration-200"
        leave-from-class="opacity-100 scale-100"
        leave-to-class="opacity-0 scale-95"
    >
      <div v-if="isExpanded"
           class="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm"
           @click.self="toggleExpand">
        <div class="relative w-[400px] overflow-hidden rounded-2xl
                    bg-gradient-to-b from-[#1a2234] to-[#0d1117]">
          <!-- Close Button -->
          <button @click="toggleExpand"
                  class="absolute top-3 right-3 z-10 p-1.5 rounded-full bg-black/40 hover:bg-black/60
                         text-white/80 hover:text-white transition-all duration-200">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>

          <!-- Large Poster -->
          <div class="aspect-[2/3] relative overflow-hidden">
            <img :src="movieData?.cover_url"
                 :alt="movieData?.title"
                 class="w-full h-full object-cover"
            />
          </div>

          <!-- Movie Info -->
          <div class="p-4 bg-gradient-to-b from-[#1a2234]/80 to-[#0d1117]">
            <div class="flex items-center justify-between mb-2">
              <h2 class="text-lg font-bold text-white line-clamp-1">{{ movieData?.title }}</h2>
              <div class="flex items-center gap-1.5 shrink-0">
                <svg class="w-4 h-4 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                </svg>
                <span class="text-white font-semibold">{{ movieData?.average_rating }}%</span>
              </div>
            </div>

            <div class="flex items-center gap-3 text-white/70 text-sm">
              <span>{{ new Date(movieData?.release_date).getFullYear() }}</span>
              <span class="px-2 py-0.5 rounded bg-white/10">{{ movieData?.age_rating }}</span>
            </div>

            <p class="mt-3 text-white/80 text-sm line-clamp-2">
              {{ movieData?.overview }}
            </p>
          </div>
        </div>
      </div>
    </Transition>
  </div>
</template>