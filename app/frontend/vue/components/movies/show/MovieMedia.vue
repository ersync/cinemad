<script setup>
import { ref, onMounted, onUnmounted, watch, nextTick, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import TabSelector from '@/vue/components/movies/shared/TabSelector.vue'
import MediaItem from '@/vue/components/movies/show/MediaItem.vue'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"
import ScrollBooster from 'scrollbooster'


const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)
const { data: movieData } = movieStore.movieComputed(movieSlug.value)

const periods = [
  { value: 'backdrops', label: 'Backdrops' },
  { value: 'posters', label: 'Posters' },
  { value: 'videos', label: 'Videos' },
]

const mediaUrls = ref([])
const iframeVideos = ref([])
const activeTab = ref('backdrops')
const isDragging = ref(false)
const lightboxImage = ref(null)
const viewport = ref(null)
const content = ref(null)
const canScrollLeft = ref(false)
const canScrollRight = ref(false)
let scrollBooster = null
let dragStartTime = 0
let dragStartPosition = { x: 0, y: 0 }

const isTouchDevice = () => {
  return 'ontouchstart' in window ||
      navigator.maxTouchPoints > 0 ||
      navigator.msMaxTouchPoints > 0
}

const getMediaArray = (type) => {
  if (!movieData.value?.media || !movieData.value.media[type]) return []

  const mediaSection = movieData.value.media[type]

  if (mediaSection && mediaSection.media && Array.isArray(mediaSection.media)) {
    return mediaSection.media
  }

  return []
}

const loadMedia = (mediaType) => {
  try {
    let media = []

    media = getMediaArray(mediaType)

    mediaUrls.value = media
    activeTab.value = mediaType
    iframeVideos.value = []

    if (scrollBooster) {
      try {
        scrollBooster.scrollTo({ x: 0, y: 0 })
      } catch (err) {
        console.error('Error scrolling with ScrollBooster:', err)
      }
    } else if (viewport.value) {
      viewport.value.scrollTo({ left: 0, behavior: 'smooth' })
    }

    nextTick(() => {
      checkScroll()
    })
  } catch (err) {
    console.error('Failed to load media:', err)
    mediaUrls.value = []
  }
}

watch(() => movieData.value?.media, (newMedia) => {
  if (newMedia) {
    loadMedia(activeTab.value)
  }
}, { deep: true })

const handlePeriodSelected = (mediaType) => {
  loadMedia(mediaType)
}

const turnToIframe = (index) => {
  const dragDistance = Math.abs(scrollBooster?.getState()?.position?.x - (dragStartPosition?.x || 0)) || 0
  const dragTime = Date.now() - dragStartTime

  if (dragTime < 200 && dragDistance < 5) {
    if (!iframeVideos.value.includes(index)) {
      iframeVideos.value.push(index)
    }
  }
}

const closeIframe = (index) => {
  iframeVideos.value = iframeVideos.value.filter(i => i !== index)
}

const openLightbox = (image) => {
  if (isTouchDevice()) {
    lightboxImage.value = image
    return
  }

  const dragDistance = Math.abs(scrollBooster?.getState()?.position?.x - (dragStartPosition?.x || 0)) || 0
  const dragTime = Date.now() - dragStartTime

  if (dragTime < 200 && dragDistance < 5) {
    lightboxImage.value = image
  }
}

const closeLightbox = () => {
  lightboxImage.value = null
}

const scroll = (direction) => {
  if (!viewport.value || !content.value) return

  const scrollAmount = 500
  const currentPosition = scrollBooster ? scrollBooster.getState().position.x : viewport.value.scrollLeft

  if (scrollBooster) {
    scrollBooster.scrollTo({
      x: direction === 'left' ? currentPosition - scrollAmount : currentPosition + scrollAmount,
      y: 0
    })
  } else {
    viewport.value.scrollTo({
      left: direction === 'left' ? currentPosition - scrollAmount : currentPosition + scrollAmount,
      behavior: 'smooth'
    })
  }
}

const checkScroll = () => {
  if (!viewport.value || !content.value) return

  if (scrollBooster) {
    const state = scrollBooster.getState()
    canScrollLeft.value = state.position.x > 0
    canScrollRight.value = state.position.x < (content.value.scrollWidth - viewport.value.clientWidth)
  } else {
    const { scrollLeft, scrollWidth, clientWidth } = viewport.value
    canScrollLeft.value = scrollLeft > 0
    canScrollRight.value = scrollLeft < scrollWidth - clientWidth - 10
  }
}

const initScrollBooster = () => {
  if (!viewport.value || !content.value) return

  if (!isTouchDevice()) {
    try {
      scrollBooster = new ScrollBooster({
        viewport: viewport.value,
        content: content.value,
        scrollMode: 'native',
        direction: 'horizontal',
        onDrag: ({ isDragging: dragging }) => {
          isDragging.value = dragging
        },
        onPointerDown: () => {
          dragStartTime = Date.now()
          if (scrollBooster) {
            dragStartPosition = scrollBooster.getState().position
          }
        },
        onUpdate: ({ position }) => {
          if (viewport.value) {
            canScrollLeft.value = position.x > 0
            canScrollRight.value = position.x < (content.value.scrollWidth - viewport.value.clientWidth)
          }
        }
      })
    } catch (err) {
      console.error('Error initializing ScrollBooster:', err)
    }
  } else {
    viewport.value.style.overflowX = 'auto'
    viewport.value.style.WebkitOverflowScrolling = 'touch'
  }
}

watch(mediaUrls, () => {
  nextTick(() => {
    checkScroll()
  })
})

onMounted(() => {
  nextTick(() => {
    initScrollBooster()
    loadMedia('backdrops')
  })
})

onUnmounted(() => {
  if (scrollBooster) {
    try {
      scrollBooster.destroy()
    } catch (err) {
      console.error('Error destroying ScrollBooster:', err)
    }
  }
})
</script>

<template>
  <div class="flex flex-col relative mb-10">
    <!-- Header -->
    <div class="flex gap-2 sm:gap-5 justify-between items-center mb-5">

      <SectionHeading
          title="Media"
      />

      <TabSelector
          :options="periods"
          :selected-value="activeTab"
          @tab-selected="handlePeriodSelected"
          class="bg-white/5 backdrop-blur-sm rounded-full"
      />
    </div>

    <!-- Media Slider Container -->
    <div class="relative group">
      <!-- Slider -->
      <div class="overflow-hidden" ref="viewport">
        <div class="flex gap-1 pb-4 pt-2" ref="content">
          <MediaItem
              v-for="(media, index) in mediaUrls"
              :key="index"
              :media="media"
              :isIframe="iframeVideos.includes(index)"
              :is-dragging="isDragging"
              @turn-to-iframe="turnToIframe(index)"
              @close-iframe="closeIframe(index)"
              @open-lightbox="openLightbox"
              class="flex-none"
          />
        </div>
      </div>

      <!-- Navigation Arrows -->
      <button v-if="canScrollLeft"
              @click="scroll('left')"
              class="absolute left-0 top-1/2 -translate-y-1/2 -translate-x-4
                     bg-white/90 hover:bg-white p-2 rounded-full shadow-lg
                     transition-all duration-200 z-10 opacity-0 group-hover:opacity-100
                     group-hover:translate-x-2">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
        </svg>
      </button>

      <button v-if="canScrollRight"
              @click="scroll('right')"
              class="absolute right-0 top-1/2 -translate-y-1/2 translate-x-4
                     bg-white/90 hover:bg-white p-2 rounded-full shadow-lg
                     transition-all duration-200 z-10 opacity-0 group-hover:opacity-100
                     group-hover:-translate-x-2">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
        </svg>
      </button>
    </div>

    <!-- Lightbox -->
    <Transition name="fade">
      <div v-if="lightboxImage"
           class="fixed inset-0 bg-black/90 z-50 flex items-center justify-center select-none"
           @click="closeLightbox">
        <img :src="lightboxImage"
             class="max-w-[90vw] max-h-[90vh] object-contain"
             @click.stop>
        <button @click="closeLightbox"
                class="absolute top-4 right-4 text-white hover:text-gray-300">
          <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>
    </Transition>
  </div>
</template>

<style scoped>
.scrollbar-hide {
  -ms-overflow-style: none;
  scrollbar-width: none;
}

.scrollbar-hide::-webkit-scrollbar {
  display: none;
}

.overflow-x-auto {
  scroll-behavior: smooth;
  -webkit-overflow-scrolling: touch;
}

.overflow-hidden::-webkit-scrollbar,
.overflow-x-auto::-webkit-scrollbar {
  height: 6px;
}

.overflow-hidden::-webkit-scrollbar-thumb,
.overflow-x-auto::-webkit-scrollbar-thumb {
  @apply bg-gray-300 rounded-full hover:bg-gray-400 transition-colors;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>