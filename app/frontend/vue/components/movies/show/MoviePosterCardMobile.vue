<script setup>
import { ref, computed } from 'vue'
import { useMovieStore } from "@/vue/stores/movieStore"

const props = defineProps({
  movieSlug: {
    type: String,
    required: true
  }
})

const movieStore = useMovieStore()
const { data: movieData } = movieStore.movieComputed(props.movieSlug)

const isExpanded = ref(false)

const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}

const formattedYear = computed(() => {
  return movieData.value?.release_date
      ? new Date(movieData.value.release_date).getFullYear()
      : null
})

const formattedRating = computed(() => {
  return Math.round(movieData.value?.average_rating || 0)
})
</script>

<template>
  <div class="relative max-w-[280px] mx-auto">
    <!-- Card Container -->
    <div class="space-y-4 transform transition-all duration-300"
         :class="{ 'scale-105': isExpanded }">
      <!-- Poster Card -->
      <div class="rounded-2xl overflow-hidden
                  shadow-[0_20px_50px_rgba(0,0,0,0.3)]
                  hover:shadow-[0_30px_60px_rgba(0,0,0,0.4)]">
        <div class="relative aspect-[2/3]">
          <img
              v-if="movieData?.cover_url"
              :src="movieData.cover_url"
              :alt="movieData?.title"
              class="w-full h-full object-cover"
              loading="lazy"
          />

          <!-- Hover overlay -->
          <div
              @click="toggleExpand"
              class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent
                    opacity-0 hover:opacity-100 transition-opacity duration-300
                    flex items-end justify-center p-6"
          >
            <button class="px-6 py-2 rounded-full text-sm font-medium
                          bg-white/10 backdrop-blur-md border border-white/10
                          transition-all duration-300
                          flex items-center gap-2 text-white">
              <span>{{ isExpanded ? 'Collapse' : 'Expand' }}</span>
              <svg class="w-4 h-4 -scale-100" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      :d="isExpanded ? 'M19 9l-7 7-7-7' : 'M5 15l7-7 7 7'"/>
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Expanded Content -->
      <div v-if="isExpanded"
           class="bg-white/10 backdrop-blur-md rounded-2xl p-6 space-y-4
                  transform transition-all duration-300 animate-fadeIn">
        <!-- Title -->
        <h3 class="text-lg font-bold text-white">{{ movieData?.title }}</h3>

        <!-- Release Date & Rating -->
        <div class="flex items-center gap-4 text-white/80">
          <span>{{ formattedYear }}</span>
          <div class="flex items-center gap-1">
            <svg class="w-4 h-4 text-yellow-400" viewBox="0 0 20 20" fill="currentColor">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
            </svg>
            <span>{{ formattedRating }}%</span>
          </div>
          <span class="px-2 py-1 rounded-md bg-white/20 text-sm">
            {{ movieData?.age_rating }}
          </span>
        </div>

        <!-- Overview -->
        <p class="text-white/70 text-sm line-clamp-3">
          {{ movieData?.overview }}
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fadeIn {
  animation: fadeIn 0.3s ease-out;
}
</style>