<script setup>
import { ref, computed, watchEffect } from 'vue'
import { useUserInteractionStore } from "@/vue/stores/userInteractionStore"
import { useToast } from 'vue-toastification'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'

const props = defineProps({
  disabled: {
    type: Boolean,
    default: false
  },
  movieSlug: {
    type: String,
    required: true
  }
})

// Rating steps configuration
const ratingSteps = [
  { startPercentage: 21, endPercentage: 26.5, rate: 10, width: '10%' },
  { startPercentage: 26.5, endPercentage: 34.85, rate: 20, width: '20%' },
  { startPercentage: 34.85, endPercentage: 42, rate: 30, width: '30%' },
  { startPercentage: 42, endPercentage: 51, rate: 40, width: '40%' },
  { startPercentage: 51, endPercentage: 57, rate: 50, width: '50%' },
  { startPercentage: 57, endPercentage: 66, rate: 60, width: '60%' },
  { startPercentage: 66, endPercentage: 72, rate: 70, width: '70%' },
  { startPercentage: 72, endPercentage: 81, rate: 80, width: '80%' },
  { startPercentage: 81, endPercentage: 87, rate: 90, width: '90%' },
  { startPercentage: 87, endPercentage: 93, rate: 100, width: '100%' }
]

const interactionStore = useUserInteractionStore()
const toast = useToast()
const { handleError } = useErrorHandler(toast)

const { userRating, error } = interactionStore.movieInteractionsComputed(props.movieSlug)

const rateWidth = computed(() => {
  return ratingSteps.find(step => step.rate === userRating.value)?.width || 0
})

const hoveredRateWidth = ref(0)
const ratingContainerRef = ref(null)

const calculateCursorPosition = (event) => {
  if (!ratingContainerRef.value) return 0

  const ratingContainerWidth = ratingContainerRef.value.offsetWidth
  const mouseX = event.clientX - ratingContainerRef.value.getBoundingClientRect().left
  return (mouseX / ratingContainerWidth) * 100
}

const setRate = async (event) => {
  try {
    const cursorPosition = calculateCursorPosition(event)
    const newRate = ratingSteps.find(ratingStep =>
        cursorPosition > ratingStep.startPercentage &&
        cursorPosition < ratingStep.endPercentage
    )?.rate || 0

    const result = await interactionStore.setRate(props.movieSlug, parseInt(newRate))
    if (!result.success) {
      throw new Error(result.error)
    }
    resetHoveredRateWidth()
  } catch (err) {
    handleError(err, 'Failed to set rating. Please try again.')
  }
}

const unsetRate = async () => {
  try {
    const result = await interactionStore.unsetRate(props.movieSlug)
    if (!result.success) {
      throw new Error(result.error)
    }
    resetHoveredRateWidth()
  } catch (err) {
    handleError(err, 'Failed to unset rating. Please try again.')
  }
}

// UI interaction handlers
const setHoveredRateWidth = (event) => {
  const cursorPosition = calculateCursorPosition(event)
  hoveredRateWidth.value = ratingSteps.find(step =>
      cursorPosition > step.startPercentage &&
      cursorPosition < step.endPercentage
  )?.width || '0'
}

const resetHoveredRateWidth = () => {
  hoveredRateWidth.value = 0
}

watchEffect(() => {
  if (error.value) {
    handleError(error.value)
  }
})
</script>

<template>
  <div class="relative group cursor-pointer h-full py-1">
    <div class="flex justify-center items-center w-11 h-11 bg-black border border-white/5 rounded-full hover:scale-105 transition-all">
      <svg class="h-[18px] w-[18px]" :class="{'text-yellow-300': userRating}">
        <use xlink:href="#star"></use>
      </svg>

      <!-- Rating popup -->
      <div v-if="!disabled" v-cloak
           ref="ratingContainerRef"
           class="flex justify-center items-center absolute top-full -right-[140%] z-40 w-[210px] h-[65px]
                  invisible opacity-0 group-hover:opacity-100 group-hover:visible transition-all
                  duration-200 delay-75 gap-2 rounded-md bg-gradient-to-br from-[#033258] to-[#032541]
                  text-white cursor-pointer">

        <!-- Unrate button -->
        <button @click.prevent="unsetRate" :disabled="!userRating">
          <svg class="w-5 h-5 left-2 bottom-0 top-0 my-auto">
            <use xlink:href="#circle-minus"></use>
          </svg>
        </button>

        <!-- Star rating display -->
        <span @mousemove="setHoveredRateWidth"
              @mouseleave="resetHoveredRateWidth"
              class="relative inline-block flex justify-center items-center mb-1">
          <!-- Hovered stars (preview) -->
          <a :style="{width: hoveredRateWidth}"
             @click.prevent="setRate"
             class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap
                    my-auto child:inline-block overflow-hidden text-yellow-200 mt-1.5">
            <span v-for="index in 5" :key="`hover-${index}`">
              <svg class="h-8 w-8">
                <use xlink:href="#star"></use>
              </svg>
            </span>
          </a>

          <!-- Actual rated stars -->
          <a :style="{width: rateWidth}"
             class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap
                    my-auto child:inline-block overflow-hidden text-yellow-400 mt-1.5 pointer-events-none">
            <span v-for="index in 5" :key="`rate-${index}`">
              <svg class="h-8 w-8">
                <use xlink:href="#star"></use>
              </svg>
            </span>
          </a>

          <!-- Empty stars -->
          <span v-for="index in 5" :key="`empty-${index}`">
            <svg class="h-8 w-8">
              <use xlink:href="#star-empty"></use>
            </svg>
          </span>
        </span>
      </div>
    </div>
  </div>
</template>