<!-- app/frontend/vue/components/MovieCarousel.vue -->
<template>
  <div class="flex flex-col relative my-7.5" :style="{ height: height || '' }">
    <div class="flex gap-5 items-center">
      <h2 class="font-SourceProSemiBold text-[1.5rem]">{{ title }}</h2>

      <period-selector
          :periods="periods"
          :active-period-index="activePeriodIndex"
          @period-changed="handlePeriodChange"
      />
    </div>

    <div
        class="scrollable-wrapper fading"
        :class="{ 'scrollbar': showScrollbar }"
        :style="backgroundBarStyle"
    >
      <div class="scrollable-content flex gap-5 my-5">
        <movie-card
            v-for="movie in displayedMovies"
            :key="movie.id"
            :movie="movie"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import MovieCard from './MovieCard.vue'
import PeriodSelector from './PeriodSelector.vue'
import { useErrorHandler } from '../composables/useErrorHandler'
import { useMovieStore } from '../stores/movieStore'
import { shuffle } from 'lodash'

// Props definition
const props = defineProps({
  title: {
    type: String,
    required: true
  },
  periods: {
    type: Array,
    default: () => []
  },
  movies: {
    type: Array,
    required: true
  },
  height: {
    type: String,
    default: ''
  },
  showScrollbar: {
    type: Boolean,
    default: false
  },
  backgroundBar: {
    type: Boolean,
    default: false
  }
})

// Setup logic
const { handleError } = useErrorHandler()
const movieStore = useMovieStore()
const activePeriodIndex = ref(0)

const displayedMovies = computed(() => {
  try {
    return shuffle(props.movies)
  } catch (error) {
    handleError(error)
    return []
  }
})

const backgroundBarStyle = computed(() => {
  if (!props.backgroundBar) return {}
  return {
    background: "url('https://iili.io/J1lXhX9.png') -10px 130px / contain no-repeat"
  }
})

const handlePeriodChange = (index) => {
  activePeriodIndex.value = index
  // Add any additional period change logic here
}
</script>
<style scoped>
.scrollable-wrapper {
  overflow-x: auto;
  overflow-y: hidden;
  -webkit-overflow-scrolling: touch;
}

.scrollable-wrapper.scrollbar::-webkit-scrollbar {
  height: 8px;
}

.scrollable-wrapper.scrollbar::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.scrollable-wrapper.scrollbar::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 4px;
}

.active_tab {
  background: var(--tmdb-dark-blue);
  color: white;
}
</style>