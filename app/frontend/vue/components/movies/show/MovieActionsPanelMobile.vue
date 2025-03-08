<script setup>
import { ref, computed, onMounted, watchEffect } from 'vue'
import { useToast } from 'vue-toastification'
import { useUserInteractionStore } from "@/vue/stores/userInteractionStore"
import { useMovieStore } from '@/vue/stores/movieStore'
import { useAuthStore } from '@/vue/stores/authStore'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import AvgRateBadge from "@/vue/components/movies/shared/AvgRateBadge.vue"
import StarRating from '@/vue/components/movies/shared/StarRating.vue'

const props = defineProps({
  movieSlug: {
    type: String,
    required: true
  }
})

const emit = defineEmits(['panel-mounted'])
const isReady = ref(false)

const interactionStore = useUserInteractionStore()
const movieStore = useMovieStore()
const authStore = useAuthStore()
const toast = useToast()
const { handleError } = useErrorHandler()

const {
  isFavorite,
  isInWatchlist,
  userRating,
  error,
  isLoading
} = interactionStore.movieInteractionsComputed(props.movieSlug)

const { data: movieData } = movieStore.movieComputed(props.movieSlug)
const averageRating = computed(() => movieData.value?.average_rating || 0)

const isAuthenticated = computed(() => authStore.isAuthenticated)

const handleAction = async (action, message, errorMessage) => {
  try {
    const result = await action(props.movieSlug)
    if (!result.success) {
      throw new Error(result.error)
    }
    if (message) {
      toast.success(message, { timeout: 2000 })
    }
  } catch (err) {
    handleError(err, errorMessage)
  }
}

const toggleFavorite = () => {
  if (!isAuthenticated.value) return

  handleAction(
      interactionStore.toggleFavorite,
      isFavorite.value ? 'Removed from favorites' : 'Added to favorites',
      'Failed to toggle favorite status'
  )
}

const toggleWatchlist = () => {
  if (!isAuthenticated.value) return

  handleAction(
      interactionStore.toggleWatchlist,
      isInWatchlist.value ? 'Removed from watchlist' : 'Added to watchlist',
      'Failed to toggle watchlist status'
  )
}

const handleRate = async (rating) => {
  if (!isAuthenticated.value) return

  handleAction(
      () => interactionStore.setRate(props.movieSlug, rating),
      'Rating updated',
      'Failed to update rating'
  )
}

// Error handling
watchEffect(() => {
  if (error.value && isAuthenticated.value) {
    handleError(error.value)
  }
})

onMounted(() => {
  isReady.value = true
  emit('panel-mounted')
})
</script>

<template>
  <div class="engagement-strip flex justify-between px-3 py-2">
    <div class="flex items-center gap-3">
      <AvgRateBadge
          :average-rating="averageRating"
          size="small-chart"
          :should-animate="true"
      />
      <span class="font-semibold text-xs text-white/85 hidden min-[372px]:block w-12">
        Average Score
      </span>
    </div>

    <div class="divider self-center"></div>

    <div class="actions gap-2">
      <div class="relative group">
        <button
            @click="toggleFavorite"
            class="action-btn"
            :disabled="!isAuthenticated || isLoading"
        >
          <span class="action-icon" :class="[
            isFavorite
              ? 'bg-black/70 text-rose-700'
              : 'text-rose-300/70 bg-rose-50/10'
          ]">
            <svg class="w-3.5 h-3.5 transition-transform duration-200" viewBox="0 0 24 24" fill="currentColor">
              <path v-if="isFavorite" d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
              <path v-else d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35zM7.5 5C5.5 5 4 6.5 4 8.5c0 2.89 3.14 5.74 8 10.05 4.86-4.31 8-7.16 8-10.05C20 6.5 18.5 5 16.5 5c-1.54 0-3.04.99-3.56 2.36h-1.87C10.54 5.99 9.04 5 7.5 5z"/>
            </svg>
          </span>
        </button>
        <div v-if="!isAuthenticated" class="tooltip">
          Please login to add to favorites
        </div>
      </div>

      <div class="relative group">
        <button
            @click="toggleWatchlist"
            class="action-btn"
            :disabled="!isAuthenticated || isLoading"
        >
          <span class="action-icon" :class="[
            isInWatchlist
              ? 'bg-black/70 text-purple-400'
              : 'text-purple-400/70 bg-purple-50/10'
          ]">
            <svg class="w-3.5 h-3.5 transition-transform duration-200" viewBox="0 0 24 24" fill="currentColor">
              <path v-if="isInWatchlist" d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
              <path v-else d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2zm0 15l-5-2.18L7 18V5h10v13z"/>
            </svg>
          </span>
        </button>
        <div v-if="!isAuthenticated" class="tooltip">
          Please login to manage watchlist
        </div>
      </div>

      <div class="relative group">
        <StarRating
            :movie-slug="props.movieSlug"
            :rating="userRating"
            :disabled="!isAuthenticated || !isReady || isLoading"
            @rate="handleRate"
            :show-rating="true"
        />
        <div v-if="!isAuthenticated" class="tooltip rating-tooltip">
          Please login to rate movies
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.engagement-strip {
  background: transparent;
}

.divider {
  width: 1px;
  height: 2rem;
  background: rgba(188, 183, 184, 0.6);
  margin: 0 0.3rem;
}

.actions {
  display: flex;
  align-items: center;
}

.action-btn {
  padding: 0;
  background: none;
  border: none;
  cursor: pointer;

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
}

.action-icon {
  width: 2rem;
  height: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 9999px;
  transition: all 0.2s;
}

.tooltip {
  @apply absolute bottom-full left-1/2 -translate-x-1/2 mb-4 px-2 py-1
  bg-black text-white text-xs rounded whitespace-nowrap z-10
  opacity-0 group-hover:opacity-100 transition-opacity duration-200;
}

.rating-tooltip {
  @apply left-1/4 mb-4;
}

:deep(.star-rating) {
  background: transparent !important;
  box-shadow: none !important;
  padding: 0 !important;
}
</style>