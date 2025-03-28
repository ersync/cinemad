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
    // Vimeo thumbnails require an API call, so we'll use a placeholder
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
}
</script>

<template>
  <div class="media-item-container" :class="{ 'is-dragging': isDragging }">
    <!-- For images (backdrops/posters) -->
    <div v-if="!isVideo(media)" 
         :class="[
           'media-item-wrapper',
           mediaType === 'posters' ? 'poster' : 'backdrop'
         ]"
         @click="handleImageClick">
      <div class="media-item-placeholder"></div>
      <img :src="media" 
           class="media-item-image" 
           :class="{ 'loaded': imageLoaded }"
           loading="lazy"
           @load="handleImageLoaded"
           @error="handleImageError" />
    </div>
    
    <!-- For videos -->
    <div v-else class="media-item-wrapper backdrop">
      <div v-if="!isIframe" 
           class="relative cursor-pointer" 
           @click="handleVideoClick">
        <div class="media-item-placeholder"></div>
        <img :src="getVideoThumbnail(media)" 
             class="media-item-image"
             :class="{ 'loaded': imageLoaded }"
             loading="lazy"
             @load="handleImageLoaded"
             @error="handleImageError" />
        <div class="absolute inset-0 flex items-center justify-center">
          <div class="w-16 h-16 rounded-full bg-black/50 flex items-center justify-center">
            <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 24 24">
              <path d="M8 5v14l11-7z" />
            </svg>
          </div>
        </div>
      </div>
      
      <!-- Video iframe -->
      <div v-else class="relative">
        <iframe 
          :src="getVideoEmbedUrl(media)" 
          class="w-full h-full absolute inset-0" 
          frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
        </iframe>
        <button 
          @click="handleCloseIframe" 
          class="absolute top-2 right-2 bg-black/70 hover:bg-black text-white p-1 rounded-full z-10">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.media-item-container {
  flex: 0 0 auto;
  position: relative;
  margin-right: 4px;
}

.media-item-wrapper {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
  background-color: #1a1a1a;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.backdrop {
  width: 480px;
  height:270px;
}

.poster {
  height:270px;
}

.media-item-placeholder {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #1a1a1a;
}

.media-item-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.media-item-image.loaded {
  opacity: 1;
}

.is-dragging {
  cursor: grabbing;
}

</style>