<template>
  <div class="flex justify-around items-center select-none">
    <div class="flex justify-center items-center mb-4">
      <MovieScore :movie-id="movieId" :line-width="3" :size="44" chart-size="base-chart"/>
    </div>
    <div>
      <MovieRating :movie-id="movieId"/>
    </div>
  </div>
</template>

<script setup>
import {onMounted} from 'vue'
import {useToast} from 'vue-toastification'
import {useMovieStore} from "@/vue/stores/movieStore"
import MovieRating from "@/vue/components/MovieRating.vue"
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

// Lifecycle hooks
onMounted(async () => {
  try {
    await store.fetchMovieDetails(props.movieId)
  } catch (err) {
    handleError(err, 'Failed to load movie data. Please refresh the page.')
  }
})
</script>