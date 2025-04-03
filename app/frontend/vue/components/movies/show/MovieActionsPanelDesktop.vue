<script setup>
import { ref, computed, onMounted, watchEffect } from 'vue'
import { useToast } from 'vue-toastification'
import { useAuthStore } from '@/vue/stores/authStore'
import { useMovieStore } from '@/vue/stores/movieStore'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import RateButton from "@/vue/components/movies/show/RateButton.vue"
import ActionButton from "@/vue/components/movies/show/ActionButton.vue"
import AvgRateBadge from "@/vue/components/movies/shared/AvgRateBadge.vue"

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
const { handleError } = useErrorHandler(toast)

const {
  isFavorite,
  isInWatchlist,
  isLoading,
  error
} = interactionStore.movieInteractionsComputed(props.movieSlug)

const { data: movieData } = movieStore.movieComputed(props.movieSlug)
const averageRating = computed(() => movieData.value?.average_rating || 0)

const isAuthenticated = computed(() => authStore.isAuthenticated)

const handleAction = async (action, message, errorMessage) => {
  try {
    const result = await action(props.movieSlug)
    if (result.success && message) {
      toast.success(message, { timeout: 2000 })
    } else if (!result.success) {
      throw new Error(result.error)
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
      'Failed to toggle favorite status. Please try again.'
  )
}

const toggleWatchlist = () => {
  if (!isAuthenticated.value) return

  handleAction(
      interactionStore.toggleWatchlist,
      isInWatchlist.value ? 'Removed from watchlist' : 'Added to watchlist',
      'Failed to toggle watchlist status. Please try again.'
  )
}

const actions = computed(() => [
  {
    key: 'favorite',
    isActive: isFavorite.value,
    iconHref: '#heart',
    activeClass: 'text-rose-500',
    onClick: toggleFavorite,
    tooltip: !isAuthenticated.value ? 'Please login to add to favorites' : null,
    disabled: !isAuthenticated.value
  },
  {
    key: 'watchlist',
    isActive: isInWatchlist.value,
    iconHref: '#bookmark',
    activeClass: 'text-purple-400',
    onClick: toggleWatchlist,
    tooltip: !isAuthenticated.value ? 'Please login to manage watchlist' : null,
    disabled: !isAuthenticated.value
  }
])

watchEffect(() => {
  if (error.value && isAuthenticated.value) {
    handleError(error.value)
  }
})

onMounted(async () => {
  isReady.value = true
  emit('panel-mounted')
})
</script>

<template>
  <div class="flex justify-center items-center select-none max-lg:mr-4 max-md:mr-2">
    <div class="flex justify-center items-center gap-x-3">
      <div class="h-[68px] w-[68px] flex justify-center items-center hover:scale-110 cursor-pointer transition-all mr-1 sm:mr-0">
        <AvgRateBadge
            v-if="isReady"
            :average-rating="averageRating"
            size="big-chart"
            :should-animate="true"
        />
      </div>
      <span class="block font-SourceProBold leading-[10px]">
        Avg <span class="hidden sm:block"><br></span> Score
      </span>
    </div>
  </div>
  <div class="flex items-center justify-start gap-3 md:gap-5 lg:gap-x-5 flex-wrap select-none">
    <div v-for="action in actions" :key="action.key" class="relative group">
      <ActionButton
          :label="action.key"
          :is-active="action.isActive"
          :icon-href="action.iconHref"
          :active-class="action.activeClass"
          :on-click="action.onClick"
          :disabled="action.disabled"
      />
      <div v-if="action.tooltip"
           class="absolute bottom-full left-1/2 -translate-x-1/2 px-2 py-1 mb-1
                  bg-black text-white text-sm rounded whitespace-nowrap z-10
                  opacity-0 group-hover:opacity-100 transition-opacity duration-200
                  pointer-events-none">
        {{ action.tooltip }}
      </div>
    </div>
    <div class="relative group">
      <RateButton
          :disabled="!isAuthenticated"
          :movie-slug="props.movieSlug"
      />
      <div v-if="!isAuthenticated"
           class="absolute bottom-full left-1/2 -translate-x-1/2 px-2 py-1 mb-1
                  bg-black text-white text-sm rounded whitespace-nowrap z-10
                  opacity-0 group-hover:opacity-100 transition-opacity duration-200
                  pointer-events-none">
        Please login to rate movies
      </div>
    </div>
  </div>
</template>