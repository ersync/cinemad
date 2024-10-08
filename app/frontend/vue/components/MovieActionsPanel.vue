<template>
  <div class="flex justify-center items-center select-none max-lg:mr-4 max-md:mr-2">
    <MovieScore :movie-id="movieId" :line-width="5" :size="68" chart-size="big-chart"
                :trigger-animation="triggerAnimation"/>
  </div>
  <div class="flex items-center justify-start gap-3 md:gap-5 lg:gap-x-5 flex-wrap select-none">
    <MovieAction
        v-for="action in actions"
        :key="action.key"
        :label="action.key"
        :is-active="action.isActive"
        :icon-href="action.iconHref"
        :active-class="action.activeClass"
        :on-click="action.onClick"
    />
    <MovieRating :movie-id="movieId"/>
    <div class="flex justify-center items-center font-SourceProSemiBold leading-[40px]">
      <svg class="inline-block w-[22px] h-[22px] mx-[5px]">
        <use xlink:href="#play"></use>
      </svg>
      <span class="hidden lg:block">Play Trailer</span>
    </div>
  </div>
</template>

<script setup>
import {ref, computed, onMounted, watch} from 'vue'
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

const triggerAnimation = ref(false)

// Get computed properties for this specific movie
const {isFavorite, isInWatchlist, error} = store.movieComputed(props.movieId)

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
    store.resetError(props.movieId)
  }
})

// Lifecycle hooks
onMounted(async () => {
  try {
    await store.fetchMovieDetails(props.movieId)
    const skeletonLoader = document.getElementById('skeleton-actions-panel-loader')
    const actualContent = document.getElementById('actions-panel')
    skeletonLoader.style.display = 'none'
    actualContent.style.display = 'flex'
    setTimeout(() => {
      triggerAnimation.value = true
    }, 300)
  } catch (err) {
    handleError(err, 'Failed to load movie data. Please refresh the page.')
  }
})
</script>