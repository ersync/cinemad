<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  media: {
    type: [String, Object],
    required: true
  },
  isIframe: {
    type: Boolean,
    default: false
  },
  isDragging: {
    type: Boolean,
    default: false
  },
  mediaType: {
    type: String,
    default: 'backdrops'
  }
})

const emit = defineEmits(['turn-to-iframe', 'close-iframe', 'open-lightbox'])

const imageLoaded = ref(false)
const imageError = ref(false)

const isVideo = (media) => {
  if (typeof media === 'string') {
    return media.includes('youtube') || media.includes('vimeo')
  }
  return false
}

const getYoutubeId = (url) => {
  const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/
  const match = url.match(regExp)
  return (match && match[2].length === 11) ? match[2] : null
}

const getVimeoId = (url) => {
  const regExp = /^.*(vimeo\.com\/)((channels\/[A-z]+\/)|(groups\/[A-z]+\/videos\/))?([0-9]+)/
  const match = url.match(regExp)
  return match ? match[5] : null
}

const getVideoThumbnail = (url) => {
  if (url.includes('youtube')) {
    const id = getYoutubeId(url)
    return id ? `https://img.youtube.com/vi/${id}/mqdefault.jpg` : ''
  } else if (url.includes('vimeo')) {
    return 'https://via.placeholder.com/300x169/1a1a1a/808080?text=Vimeo+Video'
  }
  return ''
}

const getVideoEmbedUrl = (url) => {
  if (url.includes('youtube')) {
    const id = getYoutubeId(url)
    return id ? `https://www.youtube.com/embed/${id}?autoplay=1&rel=0` : ''
  } else if (url.includes('vimeo')) {
    const id = getVimeoId(url)
    return id ? `https://player.vimeo.com/video/${id}?autoplay=1` : ''
  }
  return ''
}

const handleImageClick = () => {
  if (!props.isDragging) {
    emit('open-lightbox', props.media)
  }
}

const handleVideoClick = () => {
  if (!props.isDragging) {
    emit('turn-to-iframe')
  }
}

const handleCloseIframe = (event) => {
  event.stopPropagation()
  emit('close-iframe')
}

const handleImageLoaded = () => {
  imageLoaded.value = true
}

const handleImageError = () => {
  imageError.value = true
  imageLoaded.value = true
}
</script>


<template>
  <div class="flex-none relative mr-1" :class="{ 'cursor-grabbing': isDragging, 'cursor-grab': !isDragging }">
    <div v-if="!isVideo(media)" 
         :class="[
           'relative overflow-hidden rounded-lg shadow-md dark:shadow-gray-900/30',
           'bg-gray-100 dark:bg-gray-800',
           mediaType === 'posters' ? 'w-[120px] h-[180px] sm:w-[180px] sm:h-[270px]' : 'w-[300px] h-[169px] sm:w-[480px] sm:h-[270px]'
         ]"
         @click="handleImageClick">
      <div v-if="!imageLoaded" class="absolute inset-0 bg-gray-200 dark:bg-gray-700/80 rounded-md">
        <div class="absolute inset-0"></div>
      </div>
      <img :src="media" 
           class="absolute inset-0 w-full h-full object-cover transition-opacity duration-300"
           :class="{ 'opacity-100': imageLoaded, 'opacity-0': !imageLoaded }"
           loading="lazy"
           @load="handleImageLoaded"
           @error="handleImageError" />
    </div>
    
    <!-- For videos -->
    <div v-else 
         :class="[
           'relative overflow-hidden rounded-lg shadow-md dark:shadow-gray-900/30',
           'bg-gray-100 dark:bg-gray-800',
           'w-[300px] h-[169px] sm:w-[480px] sm:h-[270px]'
         ]">
      <div v-if="!isIframe" 
           class="relative w-full h-full cursor-pointer"
           @click="handleVideoClick">
        <!-- Skeleton loader for video thumbnails -->
        <div v-if="!imageLoaded" class="absolute inset-0 bg-gray-200 dark:bg-gray-700/80 rounded-md">
          <div class="absolute inset-0"></div>
        </div>
        <img :src="getVideoThumbnail(media)" 
             class="absolute inset-0 w-full h-full object-cover transition-opacity duration-300"
             :class="{ 'opacity-100': imageLoaded, 'opacity-0': !imageLoaded }"
             loading="lazy"
             @load="handleImageLoaded"
             @error="handleImageError" />
        <div class="absolute inset-0 flex items-center justify-center">
          <div class="w-12 h-12 sm:w-16 sm:h-16 rounded-full bg-black/50 flex items-center justify-center">
            <svg class="w-6 h-6 sm:w-8 sm:h-8 text-white" fill="currentColor" viewBox="0 0 24 24">
              <path d="M8 5v14l11-7z" />
            </svg>
          </div>
        </div>
      </div>
      
      <!-- Video iframe -->
      <div v-else class="relative w-full h-full">
        <iframe 
          :src="getVideoEmbedUrl(media)" 
          class="absolute w-full h-full top-0 left-0"
          frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
        </iframe>
        <button 
          @click="handleCloseIframe" 
          class="absolute top-2 right-2 bg-black/70 hover:bg-black text-white p-1 rounded-full z-10">
          <svg class="w-4 h-4 sm:w-5 sm:h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>
