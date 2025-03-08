<script setup>
import { ref, computed, onUnmounted, onMounted, watchEffect } from 'vue'
import { useUserInteractionStore } from "@/vue/stores/userInteractionStore"
import { useErrorHandler } from '@/vue/composables/useErrorHandler'

const props = defineProps({
  movieSlug: {
    type: String,
    required: true
  },
  disabled: {
    type: Boolean,
    default: false
  },
  readonly: {
    type: Boolean,
    default: false
  },
  showRatingText: {
    type: Boolean,
    default: true
  }
})

const interactionStore = useUserInteractionStore()
const { handleError } = useErrorHandler()

const {
  userRating,
  isLoading,
  error
} = interactionStore.movieInteractionsComputed(props.movieSlug)

const isDragging = ref(false)
const starsRef = ref(null)
const isAnimating = ref(false)
const isSubmitting = ref(false)
const previewRating = ref(0)

const currentRating = computed(() =>
    userRating.value === null ? null : userRating.value / 20
)

const isRated = computed(() => userRating.value !== null)

const calculateStars = (event) => {
  if (!starsRef.value) return 0

  const rect = starsRef.value.getBoundingClientRect()
  const x = event.type.includes('touch') ? event.touches[0].clientX : event.clientX
  const relativeX = Math.max(0, Math.min(rect.width, x - rect.left))
  const starWidth = rect.width / 5

  const starIndex = Math.floor(relativeX / starWidth)
  const starPosition = (relativeX % starWidth) / starWidth

  let rating = starIndex
  if (starPosition > 0.7) rating += 1
  else if (starPosition > 0.3) rating += 0.5

  return Math.max(0, Math.min(5, rating))
}

const handleStart = (event) => {
  if (props.disabled || props.readonly || isSubmitting.value) return
  isDragging.value = true
  isAnimating.value = true
  previewRating.value = calculateStars(event)
}

const handleMove = (event) => {
  if (!isDragging.value || props.disabled || props.readonly || isSubmitting.value) return
  previewRating.value = calculateStars(event)
}

const handleEnd = async () => {
  if (isDragging.value && !props.disabled && !props.readonly && !isSubmitting.value) {
    try {
      isSubmitting.value = true
      const serverRating = Math.round(previewRating.value * 20)

      const result = await interactionStore.setRate(props.movieSlug, serverRating)
      if (!result.success) {
        throw new Error(result.error)
      }
    } catch (err) {
      handleError(err, 'Failed to set rating')
    } finally {
      isSubmitting.value = false
    }
  }

  isDragging.value = false
  setTimeout(() => isAnimating.value = false, 200)
}

watchEffect(() => {
  if (error.value) {
    handleError(error.value)
  }
})

onUnmounted(() => {
  handleEnd()
})

const getFillPercentage = (position, rating) => {
  if (rating === null) return 0
  const fullStars = Math.floor(rating)
  const decimal = rating - fullStars

  if (position <= fullStars) return 100
  if (position === fullStars + 1 && decimal >= 0.5) return 50
  return 0
}
</script>

<template>
  <div>
    <div class="flex items-center justify-end w-full">
      <div
          class="rating-container relative h-8 touch-none select-none flex items-center"
          :class="{
          'cursor-not-allowed opacity-50': disabled || isSubmitting,
          'cursor-default': readonly
        }"
          @touchstart="handleStart"
          @touchmove="handleMove"
          @touchend="handleEnd"
          @mousedown="handleStart"
          @mousemove="handleMove"
          @mouseup="handleEnd"
          @mouseleave="handleEnd"
      >
        <div ref="starsRef" class="stars-wrapper relative inline-flex gap-0.5">
          <div v-for="position in 5" :key="`bg-${position}`" class="star-item">
            <div class="relative">
              <svg
                  class="w-4 h-4"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="#d1d5db"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>

              <svg
                  class="w-4 h-4 absolute top-0 left-0"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="#facc15"
                  :style="{
                  clipPath: `inset(0 ${100 - getFillPercentage(position, isDragging ? previewRating : currentRating)}% 0 0)`
                }"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>
            </div>
          </div>
        </div>

        <div
            v-if="isDragging && !disabled && !readonly && !isSubmitting"
            class="popup-stars absolute left-1/2 -translate-x-1/2 -top-12 inline-flex gap-2 transition-all duration-200"
            :style="{ width: starsRef.value ? `${starsRef.value.offsetWidth * 1.5}px` : 'auto' }"
        >
          <div
              v-for="position in 5"
              :key="`popup-${position}`"
              class="star-item origin-bottom"
          >
            <div class="relative">
              <svg
                  class="w-6 h-6"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="#d1d5db"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>

              <svg
                  class="w-6 h-6 absolute top-0 left-0"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="#facc15"
                  :style="{
                  clipPath: `inset(0 ${100 - getFillPercentage(position, previewRating)}% 0 0)`
                }"
              >
                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div
          class="flex items-end rating-display text-xs font-semibold ml-1 rounded select-none"
          :class="[
      isRated ? 'text-[var(--text-color,rgba(255,255,255,0.8))]' : 'bg-white/10 text-[var(--text-color,rgba(255,255,255,0.6))]',
    isSubmitting ? 'opacity-50' : '',
        !isRated ? 'min-[388px]:px-1.5 min-[388px]:py-1' : 'ml-2'
  ]"
      >
        <template v-if="showRatingText">
          <template v-if="isRated">
            <span class="w-[15px] text-right">{{ isDragging ? previewRating : currentRating }}</span>
            <span class="w-[11px] text-left">/5</span>
          </template>
          <span v-else class="w-full text-center hidden min-[388px]:inline">Rate it!</span>
        </template>
      </div>
    </div>
  </div>
</template>

<style scoped>

.rating-container {
  overflow: visible;
}

.popup-stars {
  flex-shrink: 0;
  background: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(8px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.15);
  padding: 8px 12px;
  border-radius: 12px;
  transform-origin: bottom center;
  animation: popIn 0.2s ease-out;
}

.star-item {
  transition: transform 0.2s ease;
}

@keyframes popIn {
  from {
    opacity: 0;
    transform: translate(-50%, 10px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translate(-50%, 0) scale(1);
  }
}
</style>