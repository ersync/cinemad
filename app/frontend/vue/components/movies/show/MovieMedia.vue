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
const isLoading = ref(true)
let scrollBooster = null
let dragStartTime = 0
let dragStartPosition = { x: 0, y: 0 }

const isTouchDevice = () => {
  return 'ontouchstart' in window ||
      navigator.maxTouchPoints > 0 ||
      navigator.msMaxTouchPoints > 0
}

const getMediaArray = (type) => {
  if (!movieData.value?.media || !movieData.value.media[type]) {
    console.log(`No ${type} found in store`);
    return [];
  }

  const mediaSection = movieData.value.media[type];
  
  if (Array.isArray(mediaSection)) {
    console.log(`Found ${mediaSection.length} ${type} in store (array format)`);
    return mediaSection;
  }
  
  if (mediaSection && mediaSection.media && Array.isArray(mediaSection.media)) {
    console.log(`Found ${mediaSection.media.length} ${type} in store (object.media format)`);
    return mediaSection.media;
  }
  
  console.log(`Media section for ${type} has unexpected format:`, mediaSection);
  return [];
}

const resetScrollPosition = () => {
  if (scrollBooster) {
    try {
      scrollBooster.scrollTo({ x: 0, y: 0 })
    } catch (err) {
      console.error('Error scrolling with ScrollBooster:', err)
    }
  } else if (viewport.value) {
    viewport.value.scrollTo({ left: 0, behavior: 'smooth' })
  }
}

const loadMedia = (mediaType) => {
  if (activeTab.value === mediaType) return;
  
  console.log(`Switching to media type: ${mediaType}`);
  
  iframeVideos.value = [];
  activeTab.value = mediaType;
  
  isLoading.value = true;
  // Don't clear mediaUrls immediately - this is key to the fix
  
  const mediaFromStore = getMediaArray(mediaType);
  console.log(`Media from store for ${mediaType}:`, mediaFromStore);
  
  if (mediaFromStore && mediaFromStore.length > 0) {
    let loadedImages = 0;
    const totalImages = Math.min(mediaFromStore.length, 3); // Only wait for first few images
    
    if (mediaType === 'videos') {
      mediaUrls.value = mediaFromStore;
      isLoading.value = false;
      nextTick(() => {
        resetScrollPosition();
        checkScroll();
      });
      return;
    }
    
    // Set the media URLs first
    mediaUrls.value = mediaFromStore;
    
    const handleImageLoad = () => {
      loadedImages++;
      if (loadedImages >= totalImages) {
        isLoading.value = false;
        nextTick(() => {
          resetScrollPosition();
          checkScroll();
        });
      }
    };
    
    mediaFromStore.slice(0, totalImages).forEach(url => {
      const img = new Image();
      img.onload = handleImageLoad;
      img.onerror = handleImageLoad;
      img.src = url;
    });
    
    // Safety timeout (still needed but increased)
    setTimeout(() => {
      isLoading.value = false;
    }, 3000);
  } else {
    mediaUrls.value = [];
    isLoading.value = false;
    nextTick(() => {
      resetScrollPosition();
      checkScroll();
    });
  }
}

watch(() => movieData.value?.media, (newMedia) => {
  if (newMedia) {
    const currentMediaFromStore = getMediaArray(activeTab.value)
    if (currentMediaFromStore && currentMediaFromStore.length > 0) {
      mediaUrls.value = currentMediaFromStore
      isLoading.value = false
    }
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
  <div class="flex flex-col relative mb-10 h-[241px] sm:h-[354px]">
    <!-- Header -->
    <div class="flex gap-2 sm:gap-5 justify-between items-center mb-8">
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

    <div class="relative group">
      <div class="overflow-hidden relative" ref="viewport">
        <div v-if="isLoading" class="absolute inset-0 flex justify-center items-center z-10 bg-white/5 backdrop-blur-[2px]">
          <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
          </div>
        </div>
        
        <div class="flex gap-1" ref="content">
          <!-- Content -->
          <template v-if="mediaUrls.length > 0">
            <MediaItem
                v-for="(media, index) in mediaUrls"
                :key="index"
                :media="media"
                :isIframe="iframeVideos.includes(index)"
                :is-dragging="isDragging"
                :media-type="activeTab"
                @turn-to-iframe="turnToIframe(index)"
                @close-iframe="closeIframe(index)"
                @open-lightbox="openLightbox"
                class="flex-none"
            />
          </template>
          
          <template v-if="isLoading && mediaUrls.length === 0">
            <div v-for="i in 6" :key="`skeleton-${i}`" 
                 :class="[
                   'flex-none overflow-hidden relative skeleton-loader rounded-md',
                   activeTab === 'posters' ? 'h-[253px] w-[169px]' : 'h-[169px] w-[300px]'
                 ]">
              <div class="absolute inset-0 bg-gray-100"></div>
              <div class="absolute inset-0 skeleton-shine"></div>
            </div>
          </template>
        </div>
      </div>

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

.skeleton-loader {
  background-color: #1a1a1a;
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
}

.skeleton-shine {
  background: linear-gradient(
    to right,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.1) 50%,
    rgba(255, 255, 255, 0) 100%
  );
  animation: shine 1.5s infinite;
  height: 100%;
  width: 40%;
}

@keyframes shine {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(250%);
  }
}

.spinner {
  width: 40px;
  height: 40px;
  position: relative;
}

.double-bounce1, .double-bounce2 {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background-color: rgba(59, 130, 246, 0.6);
  opacity: 0.6;
  position: absolute;
  top: 0;
  left: 0;
  animation: sk-bounce 2s infinite ease-in-out;
}

.double-bounce2 {
  animation-delay: -1.0s;
}

@keyframes sk-bounce {
  0%, 100% { 
    transform: scale(0.0);
  } 
  50% { 
    transform: scale(1.0);
  }
}
</style>