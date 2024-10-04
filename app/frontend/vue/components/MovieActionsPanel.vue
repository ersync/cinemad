<template>
  <div class="flex justify-center items-center select-none">
    <MovieScore :movie-id="movieId"/>
  </div>

  <div>
    <ul class="flex items-center justify-start gap-1.5 lg:gap-x-5 flex-wrap select-none">
      <MovieAction
          v-for="action in actions"
          :key="action.key"
          :is-active="action.isActive"
          :icon-href="action.iconHref"
          :active-class="action.activeClass"
          :on-click="action.onClick"
      />
      <MovieRating :movie-id="movieId"/>
    </ul>
  </div>
</template>

<script setup>
import {computed, onMounted, watch} from 'vue'
import {useToast} from 'vue-toastification'
import {useMovieStore} from "@/vue/stores/movieStore"
import MovieRating from "@/vue/components/MovieRating.vue"
import MovieAction from "@/vue/components/MovieAction.vue"
import MovieScore from "@/vue/components/MovieScore.vue"
import {useErrorHandler} from '@/vue/composables/useErrorHandler'

const props = defineProps({
  movieId: {
    type: String,
    required: true
  }
})

const store = useMovieStore()
const toast = useToast()
const {handleError} = useErrorHandler(toast)

// Get computed properties for this specific movie
const {isFavorite, isInWatchlist, error, isLoading} = store.movieComputed(props.movieId)

// Methods
const toggleFavorite = () => handleAction(store.toggleFavorite, 'Failed to toggle favorite status. Please try again.')
const toggleWatchlist = () => handleAction(store.toggleWatchlist, 'Failed to toggle watchlist status. Please try again.')

const handleAction = async (action, errorMessage) => {
  try {
    await action(props.movieId)
  } catch (err) {
    handleError(err, errorMessage)
  }
}

// Computed property for actions
const actions = computed(() => [
  {
    key: 'watchlist',
    isActive: isInWatchlist.value,
    iconHref: '#bookmark',
    activeClass: 'text-red-500',
    onClick: toggleWatchlist
  },
  {
    key: 'favorite',
    isActive: isFavorite.value,
    iconHref: '#heart',
    activeClass: 'text-pink-500',
    onClick: toggleFavorite
  }
])

// Watchers
watch(error, (newError) => {
  if (newError) {
    handleError(newError)
    store.resetError(props.movieId)
  }
})

// Lifecycle hooks
onMounted(async () => {
  try {
    await store.fetchMovieDetails(props.movieId)
  } catch (err) {
    handleError(err, 'Failed to load movie data. Please refresh the page.')
  }
})
</script>