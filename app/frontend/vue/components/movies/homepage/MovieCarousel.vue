<script setup>
import { ref, computed, onMounted, onBeforeUnmount, watch } from 'vue'
import MovieCard from '@/vue/components/movies/homepage/MovieCard.vue'
import MovieCardSkeleton from '@/vue/components/movies/homepage/MovieCardSkeleton.vue'
import TabSelector from '@/vue/components/movies/shared/TabSelector.vue'
import ScrollableWrapper from '@/vue/components/movies/shared/ScrollableWrapper.vue'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import { useMovieStore } from '@/vue/stores/movieStore'
import { shuffle } from 'lodash'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"
import trendingBackgroundLight from "@/assets/images/trending_background.png"
import trendingBackgroundDark from "@/assets/images/trending_background-dark.png"

const props = defineProps({
  title: {
    type: String,
    required: true
  },
  periods: {
    type: Array,
    default: () => []
  },
  movies: {
    type: Array,
    required: true
  },
  height: {
    type: String,
    default: ''
  },
  showScrollbar: {
    type: Boolean,
    default: false
  },
  backgroundBar: {
    type: Boolean,
    default: false
  },
  isLoading: {
    type: Boolean,
    default: false
  }
})

const { handleError } = useErrorHandler()
const movieStore = useMovieStore()
const selectedPeriod = ref(props.periods[0]?.toLowerCase().replace(' ', '_') || '')
const wrapperRef = ref(null)
const resizeTimer = ref(null)
const skeletonCount = ref(6)
const imagesLoaded = ref(0)
const totalImagesToLoad = ref(0)
const allImagesLoaded = ref(false)
const isLargeScreen = ref(false)
const isDarkMode = ref(false)

const getCardWidth = () => {
  return window.innerWidth >= 640 ? 150 : 130 
}

const getGapWidth = () => {
  return 20 
}

const calculateSkeletonCount = () => {
  if (!wrapperRef.value) return
  
  const containerWidth = wrapperRef.value.clientWidth
  const cardWidth = getCardWidth()
  const gapWidth = getGapWidth()
  const cardWithGapWidth = cardWidth + gapWidth
  
  const visibleCardsCount = Math.floor(containerWidth / cardWithGapWidth)
  const extraScrollCards = 4
  
  skeletonCount.value = Math.max(6, visibleCardsCount + extraScrollCards)
}

const handleResize = () => {
  if (resizeTimer.value) clearTimeout(resizeTimer.value)
  resizeTimer.value = setTimeout(() => {
    calculateSkeletonCount()
    checkScreenSize()
  }, 200)
}

const checkScreenSize = () => {
  isLargeScreen.value = window.innerWidth >= 1024
}

const checkDarkMode = () => {
  isDarkMode.value = document.documentElement.classList.contains('dark') || 
                     document.body.classList.contains('dark')
}

const displayedMovies = computed(() => {
  try {
    if (!props.movies || props.movies.length === 0) {
      return []
    }
    return shuffle(props.movies)
  } catch (error) {
    handleError(error)
    return []
  }
})

const shouldShowBackground = computed(() => {
  return props.backgroundBar && isLargeScreen.value && !props.isLoading;
})

const backgroundImage = computed(() => {
  return isDarkMode.value ? trendingBackgroundDark : trendingBackgroundLight
})

const handlePeriodChange = (newPeriod) => {
  selectedPeriod.value = newPeriod
}

const handleFading = (wrapper) => {
  const leftHorizontalOffset = wrapper.scrollLeft
  if (leftHorizontalOffset > 45) {
    wrapperRef.value.classList.add('fade_invisible')
    wrapperRef.value.classList.remove('fade_visible')
  } else {
    wrapperRef.value.classList.add('fade_visible')
    wrapperRef.value.classList.remove('fade_invisible')
  }
}

const preloadMovieImages = () => {
  if (displayedMovies.value.length > 0 && !props.isLoading) {
    imagesLoaded.value = 0
    allImagesLoaded.value = false
    
    const moviesToPreload = displayedMovies.value.slice(0, skeletonCount.value)
    totalImagesToLoad.value = moviesToPreload.length
    
    moviesToPreload.forEach(movie => {
      const img = new Image()
      img.onload = handleImageLoaded
      img.onerror = handleImageLoaded
      img.src = movie.cover_url
    })
    
    setTimeout(() => {
      allImagesLoaded.value = true
    }, 3000)
  }
}

const handleImageLoaded = () => {
  imagesLoaded.value++
  if (imagesLoaded.value >= totalImagesToLoad.value) {
    allImagesLoaded.value = true
  }
}

const setupDarkModeObserver = () => {
  checkDarkMode()
  
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.attributeName === 'class') {
        checkDarkMode()
      }
    })
  })
  
  observer.observe(document.documentElement, { attributes: true })
  observer.observe(document.body, { attributes: true })
  
  return observer
}

let darkModeObserver = null

watch(() => [props.movies, props.isLoading], () => {
  if (props.movies.length > 0 && !props.isLoading) {
    preloadMovieImages()
  }
}, { immediate: true })

onMounted(() => {
  const wrapper = wrapperRef.value
  const scrollableElement = wrapper.querySelector('.scrollable-wrapper')
  if (scrollableElement) {
    scrollableElement.addEventListener('scroll', () => handleFading(scrollableElement))
  }
  
  calculateSkeletonCount()
  checkScreenSize()
  
  window.addEventListener('resize', handleResize)
  
  if (displayedMovies.value.length > 0 && !props.isLoading) {
    preloadMovieImages()
  }
  
  darkModeObserver = setupDarkModeObserver()
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  
  if (resizeTimer.value) clearTimeout(resizeTimer.value)
  
  if (darkModeObserver) {
    darkModeObserver.disconnect()
  }
})
</script>

<template>
  <div class="flex flex-col relative my-7.5 min-h-[333px] sm:min-h-[370px]" :style="{ height: height || '' }">
    <div class="flex gap-5 items-center">
      <SectionHeading :title="title"/>
    </div>
    <div
        class="fading fade_visible relative"
        ref="wrapperRef"
        :class="{ 'with-background': shouldShowBackground }"
    >
      <div 
        v-if="shouldShowBackground" 
        class="background-image"
        :style="{
          backgroundImage: `url(${backgroundImage})`
        }"
      ></div>
      
      <scrollable-wrapper>
        <div class="flex gap-5 mt-5 relative z-10">
          <template v-if="isLoading || !allImagesLoaded">
            <movie-card-skeleton
                v-for="index in skeletonCount" 
                :key="`skeleton-${index}`"
            />
          </template>
          <template v-else>
            <movie-card
                v-for="movie in displayedMovies"
                :key="movie.id"
                :movie="movie"
                @image-loaded="handleImageLoaded"
            />
          </template>
        </div>
      </scrollable-wrapper>
    </div>
  </div>
</template>

<style scoped>
.fading {
  position: relative;
}

.fading.fade_visible::after {
  transition: linear .3s;
  opacity: 1;
}

.fading.fade_invisible::after {
  transition: linear .3s;
  opacity: 0;
}

.fading::after {
  content: "";
  width: 40px;
  height: 100%;
  position: absolute;
  top: 0;
  right: 0;
  background-image: linear-gradient(to right, rgba(246, 248, 252, 0) 0, #f6f8fc 100%);
  will-change: opacity;
  pointer-events: none;
  z-index: 15;
}

.with-background {
  position: relative;
}

.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-position: -10px 150px;
  background-size: contain;
  background-repeat: no-repeat;
  opacity: 0.3;
  pointer-events: none;
  z-index: 1;
}

body.dark .fading::after {
  background-image: linear-gradient(to right, rgba(17, 24, 39, 0) 0, #111827 100%);
}
</style>