<template>
  <div>
    <div v-if="!watchlist.length" class="text-gray-500 text-center py-8">
      <svg class="w-16 h-16 mx-auto mb-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
      </svg>
      <p class="text-lg font-medium">Your watchlist is empty</p>
      <p class="mt-2">Start adding movies to keep track of what you want to watch</p>
    </div>

    <div v-else class="flex gap-4 items-center" ref="containerRef">
      <RouterLink
          v-for="movie in visibleMovies"
          :key="movie.id"
          :to="{ name: 'movie-show', params: { slug: movie.slug }}"
          class="shrink-0 w-[130px] group relative rounded-lg overflow-hidden shadow-sm hover:shadow-md transition-shadow border movie-card"
          ref="movieCardRef"
      >
        <img
            :src="`${movie.cover_url}`"
            :alt="movie.title"
            class="w-full h-48 object-cover"
        >
        <div class="p-3">
          <h4 class="font-semibold text-sm truncate">{{ movie.title }}</h4>
          <p class="text-sm text-gray-600">{{ getYear(movie.release_date) }}</p>
        </div>
      </RouterLink>

      <div
          v-if="watchlist.length > maxVisibleCards"
          class="flex items-center justify-center h-48"
      >
        <span class="text-3xl text-gray-400">...</span>
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
  const cardWidth = 130
  const gap = 12
  const ellipsisWidth = 15

  const availableWidth = containerWidth - (props.watchlist.length > props.maxVisibleCards ? ellipsisWidth + gap : 0)
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
  @apply w-full h-48 object-cover transition-transform duration-200;
}

.movie-card:hover img {
  @apply transform scale-105;
}
</style>