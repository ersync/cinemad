<template>
  <div class="flex flex-col relative my-7.5 min-h-[333px] sm:min-h-[370px]" :style="{ height: height || '' }">
    <div class="flex gap-5 items-center">
      <SectionHeading :title="title"/>
    </div>
    <div
        class="fading fade_visible relative"
        ref="wrapperRef"
        :style="!isLoading && backgroundBar ? backgroundBarStyle : {}"
    >
      <scrollable-wrapper>
        <div class="flex gap-5 mt-5">
          <template v-if="isLoading">
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
            />
          </template>
        </div>
      </scrollable-wrapper>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import MovieCard from '@/vue/components/movies/homepage/MovieCard.vue'
import MovieCardSkeleton from '@/vue/components/movies/homepage/MovieCardSkeleton.vue'
import TabSelector from '@/vue/components/movies/shared/TabSelector.vue'
import ScrollableWrapper from '@/vue/components/movies/shared/ScrollableWrapper.vue'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import { useMovieStore } from '@/vue/stores/movieStore'
import { shuffle } from 'lodash'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"
import trendingBackground from "@/assets/images/trending_background.png"

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

// Handle window resize events
const handleResize = () => {
  if (resizeTimer.value) clearTimeout(resizeTimer.value)
  resizeTimer.value = setTimeout(() => {
    calculateSkeletonCount()
  }, 200)
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

const backgroundBarStyle = computed(() => {
  if (!props.backgroundBar) return {}
  return {
    background: `url(${trendingBackground}) -10px 130px / contain no-repeat`
  }
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

onMounted(() => {
  const wrapper = wrapperRef.value
  const scrollableElement = wrapper.querySelector('.scrollable-wrapper')
  if (scrollableElement) {
    scrollableElement.addEventListener('scroll', () => handleFading(scrollableElement))
  }
  
  calculateSkeletonCount()
  
  window.addEventListener('resize', handleResize)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize)
  
  if (resizeTimer.value) clearTimeout(resizeTimer.value)
})
</script>

<style scoped>
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
  background-image: linear-gradient(to right, rgba(246, 248, 252, 0) 0, #f6f8fc 100%);  will-change: opacity;
  will-change: opacity;
  pointer-events: none;
}
</style>