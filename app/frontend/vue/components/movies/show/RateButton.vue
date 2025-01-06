<template>
  <!-- Rating star button -->
  <div class="relative group cursor-pointer h-full py-3">
    <div
        class="flex justify-center items-center w-11 h-11 md:w-[46px] md:h-[46px] bg-tmdbDarkBlue border border-white/5 rounded-full">
      <svg class="h-4 w-4" :class="{'text-yellow-500': userRate}">
        <use xlink:href="#star"></use>
      </svg>
      <!-- Rating popup -->
      <div v-cloak
           ref="ratingContainerRef"
           class="flex justify-center items-center absolute top-full -right-[140%] z-40 w-[210px] h-[65px] invisible opacity-0 group-hover:opacity-100 group-hover:visible transition-all
                  duration-200 delay-75 gap-2 rounded-md bg-tmdbDarkBlue text-white cursor-pointer">
        <!-- Unrate button -->
        <button @click.prevent="unsetRate" :disabled="!userRate">
          <svg class="w-5 h-5 left-2 bottom-0 top-0 my-auto">
            <use xlink:href="#circle-minus"></use>
          </svg>
        </button>
        <!-- Star rating display -->
        <span @mousemove="setHoveredRateWidth"
              @mouseleave="resetHoveredRateWidth" class="relative inline-block flex justify-center items-center mb-1">
          <!-- Hovered stars (preview) -->
          <a :style="{width: hoveredRateWidth}" @click.prevent="setRate"
             class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap my-auto child:inline-block overflow-hidden text-yellow-200 mt-1.5">
            <span v-for="_ in 5" :key="_">
              <svg class="h-8 w-8">
                <use xlink:href="#star"></use>
              </svg>
            </span>
          </a>
          <!-- Actual rated stars -->
          <a :style="{width: rateWidth}"
             class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap my-auto child:inline-block overflow-hidden text-yellow-400 mt-1.5 pointer-events-none">
            <span v-for="_ in 5" :key="_">
              <svg class="h-8 w-8">
                <use xlink:href="#star"></use>
              </svg>
            </span>
          </a>
          <!-- Empty stars -->
          <span v-for="_ in 5" :key="_">
            <svg class="h-8 w-8">
              <use xlink:href="#star-empty"></use>
            </svg>
          </span>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import {ref, computed, watch, onMounted, nextTick} from 'vue'
import {useMovieStore} from "@/vue/stores/movieStore"
import {useToast} from 'vue-toastification'

export default {
  props: {
    movieId: {
      type: String,
      required: true
    },
  },
  setup(props) {
    const ratingSteps = [
      {startPercentage: 21, endPercentage: 26.5, rate: 10, width: '10%'},
      {startPercentage: 26.5, endPercentage: 34.85, rate: 20, width: '20%'},
      {startPercentage: 34.85, endPercentage: 42, rate: 30, width: '30%'},
      {startPercentage: 42, endPercentage: 51, rate: 40, width: '40%'},
      {startPercentage: 51, endPercentage: 57, rate: 50, width: '50%'},
      {startPercentage: 57, endPercentage: 66, rate: 60, width: '60%'},
      {startPercentage: 66, endPercentage: 72, rate: 70, width: '70%'},
      {startPercentage: 72, endPercentage: 81, rate: 80, width: '80%'},
      {startPercentage: 81, endPercentage: 87, rate: 90, width: '90%'},
      {startPercentage: 87, endPercentage: 93, rate: 100, width: '100%'}
    ]

    const store = useMovieStore()
    const toast = useToast()

    const {userRate, avgRate, error, isLoading} = store.movieComputed(props.movieId)
    const rateWidth = computed(() => ratingSteps.find(step => step.rate === userRate.value)?.width || 0)
    const hoveredRateWidth = ref(0)
    const ratingContainerRef = ref(null)

    const calculateCursorPosition = (event) => {
      const ratingContainerWidth = ratingContainerRef.value.offsetWidth
      const mouseX = event.clientX - ratingContainerRef.value.getBoundingClientRect().left
      return (mouseX / ratingContainerWidth) * 100
    }

    const setRate = async (event) => {
      try {
        await nextTick() // Ensure DOM is updated
        const cursorPosition = calculateCursorPosition(event)
        const newRate = ratingSteps.find(ratingStep =>
            cursorPosition > ratingStep.startPercentage && cursorPosition < ratingStep.endPercentage
        )?.rate || 0
        await store.setRate(props.movieId, parseInt(newRate))
        resetHoveredRateWidth()
      } catch (err) {
        console.error('Unexpected error in setRate:', err)
        toast.error('Failed to set rating. Please try again.')
      }
    }

    const unsetRate = async () => {
      try {
        await store.unsetRate(props.movieId)
        resetHoveredRateWidth()
      } catch (err) {
        console.error('Unexpected error in unsetRate:', err)
        toast.error('Failed to unset rating. Please try again.')
      }
    }

    const setHoveredRateWidth = (event) => {
      const cursorPosition = calculateCursorPosition(event)
      hoveredRateWidth.value = ratingSteps.find(step =>
          cursorPosition > step.startPercentage && cursorPosition < step.endPercentage
      )?.width || '0'
    }

    const resetHoveredRateWidth = () => {
      hoveredRateWidth.value = 0
    }

    const handleError = (error) => {
      const errorMessages = {
        fetch: {type: 'warning', message: error.message},
        update: {type: 'error', message: error.message},
        unknown: {type: 'error', message: error.message},
        critical: {type: 'error', message: error.message, timeout: 0},
      }

      const {type, message, timeout} = errorMessages[error.type] ||
      {type: 'error', message: 'An unexpected error occurred. Please refresh the page.', timeout: 5000}

      toast[type](message, {timeout})
    }

    onMounted(async () => {
      try {
        await store.fetchMovieDetails(props.movieId, {favorite: false, watchlist: false, avgRate: false})
        await nextTick()
      } catch (err) {
        console.error('Unexpected error in fetchMovieActions:', err)
        toast.error('Failed to load movie data. Please refresh the page.')
      }
    })

    watch(userRate, async (newVal, oldVal) => {
      if (newVal !== oldVal) {
        await store.fetchMovieDetails(props.movieId, {favorite: false, watchlist: false, rate: false})
      }
    })

    watch(() => store.error, (newError) => {
      if (newError) {
        handleError(newError)
        store.resetError()
      }
    })

    return {
      userRate,
      setRate,
      unsetRate,
      setHoveredRateWidth,
      resetHoveredRateWidth,
      hoveredRateWidth,
      rateWidth,
      ratingContainerRef
    }
  }
}
</script>