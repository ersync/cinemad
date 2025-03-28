<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import ScrollableWrapper from '@/vue/components/movies/shared/ScrollableWrapper.vue'
import RecommendationCard from '@/vue/components/movies/show/RecommendationCard.vue'
import RecommendationsSkeleton from '@/vue/components/movies/show/RecommendationsSkeleton.vue'
import { useIntersectionObserver } from '@vueuse/core'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)
const { data: movieData, isLoading: storeLoading } = movieStore.movieComputed(movieSlug.value)

const containerRef = ref(null)
const scrollableRef = ref(null)
const currentIndex = ref(0)
const showLeftControl = ref(false)
const showRightControl = ref(true)
const isVisible = ref(false)
const isLoading = ref(true)
const imagesLoaded = ref(0)
const totalImagesToLoad = ref(0)

const recommendations = computed(() => movieData.value?.recommendations || [])
const hasMultipleCards = computed(() => recommendations.value.length > 1)

const handleImageLoaded = () => {
  imagesLoaded.value++
  if (imagesLoaded.value >= Math.min(totalImagesToLoad.value, 5)) {
    isLoading.value = false
  }
}

// Preload recommendation images
const preloadRecommendationImages = () => {
  if (recommendations.value.length > 0 && !storeLoading.value) {
    const recsToPreload = recommendations.value.slice(0, 5)
    totalImagesToLoad.value = recsToPreload.length
    
    // Reset counter
    imagesLoaded.value = 0
    isLoading.value = true
    
    // Preload images
    recsToPreload.forEach(movie => {
      const img = new Image()
      img.onload = handleImageLoaded
      img.onerror = handleImageLoaded
      img.src = movie.background_url
    })
    
    // Fallback in case some images never load
    setTimeout(() => {
      isLoading.value = false
    }, 3000)
  } else if (recommendations.value.length === 0 && !storeLoading.value) {
    isLoading.value = false
  }
}

// Watch for recommendations data changes
watch(() => [recommendations.value, storeLoading.value], () => {
  if (recommendations.value.length > 0 && !storeLoading.value) {
    preloadRecommendationImages()
  } else if (recommendations.value.length === 0 && !storeLoading.value) {
    isLoading.value = false
  }
}, { immediate: true })

const handleScroll = () => {
  if (!scrollableRef.value) return

  const scrollEl = scrollableRef.value
  const { scrollLeft, scrollWidth, clientWidth } = scrollEl

  showLeftControl.value = scrollLeft > 20
  showRightControl.value = scrollLeft < (scrollWidth - clientWidth - 20)

  if (recommendations.value.length) {
    const itemWidth = scrollWidth / recommendations.value.length
    currentIndex.value = Math.round(scrollLeft / itemWidth)
  }
}

const scrollToCard = (index) => {
  if (!scrollableRef.value || !recommendations.value.length) return

  const scrollEl = scrollableRef.value
  const itemWidth = scrollEl.scrollWidth / recommendations.value.length
  const targetPosition = index * itemWidth

  scrollEl.scrollTo({
    left: targetPosition,
    behavior: 'smooth'
  })
}

const scrollNext = () => {
  if (!scrollableRef.value) return
  const scrollEl = scrollableRef.value
  const currentScroll = scrollEl.scrollLeft
  const cardWidth = 300 + 20

  scrollEl.scrollTo({
    left: currentScroll + cardWidth,
    behavior: 'smooth'
  })
}

const scrollPrev = () => {
  if (!scrollableRef.value) return
  const scrollEl = scrollableRef.value
  const currentScroll = scrollEl.scrollLeft
  const cardWidth = 300 + 20

  scrollEl.scrollTo({
    left: currentScroll - cardWidth,
    behavior: 'smooth'
  })
}

if (typeof window !== 'undefined') {
  useIntersectionObserver(containerRef, ([{ isIntersecting }]) => {
    if (isIntersecting) {
      isVisible.value = true
    }
  }, { threshold: 0.2 })
}

onMounted(() => {
  if (scrollableRef.value) {
    scrollableRef.value.addEventListener('scroll', handleScroll)
  }
  
  if (recommendations.value.length > 0 && !storeLoading.value) {
    preloadRecommendationImages()
  }
})

onUnmounted(() => {
  if (scrollableRef.value) {
    scrollableRef.value.removeEventListener('scroll', handleScroll)
  }
})
</script>

<template>
  <section
      ref="containerRef"
      class="relative overflow-hidden mb-10"
      :class="[isVisible ? 'animate-fade-in' : 'opacity-0']"
      aria-labelledby="recommendations-heading"
  >
    <div class="flex items-center justify-between mb-8">
      <SectionHeading
          title="Recommendations"
      />

      <div v-if="hasMultipleCards && !isLoading" class="flex items-center gap-3 py-0.5">
        <div class="hidden sm:flex items-center gap-1.5">
          <button
              v-for="index in Math.max(0, recommendations.length - 2)"
              :key="index - 1"
              @click="scrollToCard(index - 1)"
              class="w-2 h-2 rounded-full transition-all duration-300 focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-indigo-500"
              :class="[
              currentIndex === (index - 1)
                ? 'bg-indigo-500 scale-125'
                : 'bg-gray-300 hover:bg-gray-400'
            ]"
              :aria-label="`Go to position ${index}`"
              :aria-current="currentIndex === (index - 1) ? 'true' : 'false'"
          ></button>
        </div>

        <div class="flex items-center gap-2 px-0.5">
          <button
              @click="scrollPrev"
              :disabled="!showLeftControl"
              class="group flex items-center justify-center w-8 h-8 sm:w-10 sm:h-10 rounded-full bg-white/80 backdrop-blur-sm border border-gray-200 shadow-sm hover:shadow transition-all duration-300 active:outline-none active:ring-2 active:ring-indigo-500 disabled:opacity-50 disabled:cursor-not-allowed"
              aria-label="See previous recommendations"
          >
            <svg class="w-4 h-4 sm:w-5 h-5 text-teal-500 transition-colors" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <button
              @click="scrollNext"
              :disabled="!showRightControl"
              class="group flex items-center justify-center w-8 h-8 sm:w-10 sm:h-10  rounded-full bg-white/80 backdrop-blur-sm border border-gray-200 shadow-sm hover:shadow transition-all duration-300 active:outline-none active:ring-2 active:ring-indigo-500 disabled:opacity-50 disabled:cursor-not-allowed"
              aria-label="See more recommendations"
          >
            <svg class="w-4 h-4 sm:w-5 h-5 text-teal-500 transition-colors" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <div class="relative overflow-hidden rounded-xl">
      <div class="scrollable-container relative">
        <ScrollableWrapper>
          <div
              ref="scrollableRef"
              class="scrollable-wrapper flex overflow-x-auto snap-x snap-mandatory hide-scrollbar"
          >
            <ul v-if="!isLoading && recommendations.length"
                class="flex gap-5 snap-x snap-mandatory"
            >
              <RecommendationCard
                  v-for="(movie, idx) in recommendations"
                  :key="movie.id"
                  :movie="movie"
                  :style="{
                    'animation-delay': `${idx * 100}ms`,
                    'opacity': isVisible ? 1 : 0,
                    'transform': isVisible ? 'translateY(0)' : 'translateY(20px)'
                  }"
                  class="transition-all duration-500 ease-out"
                  @image-loaded="handleImageLoaded"
              />
            </ul>
            <RecommendationsSkeleton v-else />
          </div>
        </ScrollableWrapper>
      </div>
    </div>

    <div
        v-if="!isLoading && recommendations.length === 0"
        class="flex flex-col items-center justify-center py-12 px-4 text-center rounded-xl bg-gray-50 border border-gray-100"
    >
      <svg class="w-16 h-16 text-gray-300 mb-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
      </svg>
      <h4 class="text-lg font-medium text-gray-700 mb-2">No recommendations found</h4>
      <p class="text-gray-500 max-w-md">We don't have any movie recommendations for this title yet. Check back later!</p>
    </div>
  </section>
</template>