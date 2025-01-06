<script setup>
import {ref, onMounted, onErrorCaptured, computed, watch, inject} from 'vue'
import { useToast } from 'vue-toastification'
import { useMovieStore } from "@/vue/stores/movieStore"
import RateButton from "@/vue/components/movies/show/RateButton.vue"
import ActionButton from "@/vue/components/movies/show/ActionButton.vue"
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import AvgRateBadge from "@/vue/components/movies/show/AvgRateBadge.vue"

const emit = defineEmits(['mounted'])
const movieId = inject("movieId")
const movieData = inject("movieData")

const store = useMovieStore()
const toast = useToast()
const { handleError } = useErrorHandler(toast)

const triggerAnimation = ref(false)

// Get computed properties for this specific movie
const { isFavorite, isInWatchlist, error } = store.movieComputed(movieId.value)
// Methods
const toggleFavorite = () => handleAction(store.toggleFavorite, 'Failed to toggle favorite status. Please try again.')
const toggleWatchlist = () => handleAction(store.toggleWatchlist, 'Failed to toggle watchlist status. Please try again.')

const handleAction = async (action, errorMessage) => {
  try {
    await action(movieId.value)
  } catch (err) {
    handleError(err, errorMessage)
  }
}

// Computed property for actions
const actions = computed(() => [
  {
    key: 'favorite',
    isActive: isFavorite.value,
    iconHref: '#heart',
    activeClass: 'text-red-500',
    onClick: toggleFavorite
  },
  {
    key: 'watchlist',
    isActive: isInWatchlist.value,
    iconHref: '#bookmark',
    activeClass: 'text-green-400',
    onClick: toggleWatchlist
  }
])

// Watchers
watch(error, (newError) => {
  if (newError) {
    handleError(newError)
    store.resetError(movieId.value)
  }
})

// Lifecycle hooks
onMounted(async () => {
  try {
    await store.fetchMovieDetails(movieId.value)
    setTimeout(() => {
      triggerAnimation.value = true
      emit('mounted')
    }, 700)
  } catch (err) {
    handleError(err, 'Failed to load movie data. Please refresh the page.')
  }
})


</script>

<template>
  <div class="flex justify-center items-center select-none max-lg:mr-4 max-md:mr-2">
    <div class="flex justify-center items-center gap-x-3">
      <div class="h-[68px] w-[68px] flex justify-center items-center hover:scale-110 cursor-pointer transition-all mr-1 sm:mr-0">
          <AvgRateBadge
              size="big-chart"
              :should-animate="true"
          />
      </div>
      <span class="block font-SourceProBold leading-[10px]">
      User <span class="hidden sm:block"><br></span> Score
    </span>
        </div>
  </div>
  <div class="flex items-center justify-start gap-3 md:gap-5 lg:gap-x-5 flex-wrap select-none">
    <ActionButton
        v-for="action in actions"
        :key="action.key"
        :label="action.key"
        :is-active="action.isActive"
        :icon-href="action.iconHref"
        :active-class="action.activeClass"
        :on-click="action.onClick"
    />
    <RateButton :movie-id="movieId"/>
    <div class="flex justify-center items-center font-SourceProSemiBold leading-[40px]">
      <svg class="inline-block w-[22px] h-[22px] mx-[5px]">
        <use xlink:href="#play"></use>
      </svg>
      <span class="hidden lg:block">Play Trailer</span>
    </div>
  </div>
</template>