<template>
  <div>
    <div v-if="!watchlist.length" class="text-gray-500 dark:text-gray-400 text-center py-8">
      <svg class="w-16 h-16 mx-auto mb-4 text-gray-400 dark:text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
      </svg>
      <p class="text-lg font-medium">Your watchlist is empty</p>
      <p class="mt-2">Start adding movies to keep track of what you want to watch</p>
    </div>
    <div v-else class="flex gap-3 sm:gap-4 items-center" ref="containerRef">
      <RouterLink
          v-for="movie in visibleMovies"
          :key="movie.id"
          :to="{ name: 'movie-show', params: { slug: movie.slug }}"
          class="shrink-0 w-[100px] sm:w-[130px] group relative rounded-lg overflow-hidden shadow-sm hover:shadow-md transition-shadow border dark:border-gray-700 movie-card bg-white dark:bg-gray-800"
          ref="movieCardRef"
      >
        <img
            :src="`${movie.cover_url}`"
            :alt="movie.title"
            class="w-full h-36 sm:h-48 object-cover"
        >
        <div class="p-2 sm:p-3">
          <h4 class="font-semibold text-xs sm:text-sm truncate dark:text-gray-100">{{ movie.title }}</h4>
          <p class="text-xs sm:text-sm text-gray-600 dark:text-gray-400">{{ getYear(movie.release_date) }}</p>
        </div>
      </RouterLink>
      <div
          v-if="watchlist.length > maxVisibleCards"
          class="flex-shrink-0 flex items-center justify-center h-36 sm:h-48 px-3 sm:px-4 rounded-lg bg-white/5 dark:bg-gray-800/30 backdrop-blur-sm border border-gray-200 dark:border-gray-700"
      >
          <span class="text-xl sm:text-2xl font-bold text-gray-500 dark:text-gray-400">...</span>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted, watch, nextTick, onBeforeUnmount } from 'vue'
import { RouterLink } from 'vue-router'
const props = defineProps({
  watchlist: {
    type: Array,
    required: true
  },
  visibleMovies: {
    type: Array,
    required: true
  },
  maxVisibleCards: {
    type: Number,
    required: true
  }
})
const emit = defineEmits(['update-visible-cards'])
const containerRef = ref(null)
const movieCardRef = ref(null)
const calculateVisibleCards = () => {
  if (!containerRef.value) return
  const containerWidth = containerRef.value.offsetWidth
  // Adjust card width based on screen size
  const isMobile = window.innerWidth < 640 // sm breakpoint in Tailwind
  const cardWidth = isMobile ? 100 : 130
  const gap = isMobile ? 12 : 16  // Adjust gap for mobile as well
  const ellipsisWidth = isMobile ? 40 : 50
  
  // If we need to show ellipsis, reserve space for it
  const reservedWidth = props.watchlist.length > props.maxVisibleCards ? (ellipsisWidth + gap) : 0
  const availableWidth = containerWidth - reservedWidth
  
  // Calculate max cards that can fit
  const maxCards = Math.floor((availableWidth + gap) / (cardWidth + gap))
  
  emit('update-visible-cards', Math.min(maxCards, props.watchlist.length))
}
const getYear = (dateString) => {
  return new Date(dateString).getFullYear()
}
onMounted(() => {
  nextTick(() => calculateVisibleCards())
  window.addEventListener('resize', calculateVisibleCards)
})
watch(() => props.watchlist, () => {
  nextTick(() => calculateVisibleCards())
}, { deep: true })
onBeforeUnmount(() => {
  window.removeEventListener('resize', calculateVisibleCards)
})
</script>
<style scoped>
.movie-card {
  @apply relative overflow-hidden rounded-lg transition-all duration-200
}
.movie-card img {
  @apply w-full transition-transform duration-200;
}
.movie-card:hover img {
  @apply transform scale-105;
}
</style>