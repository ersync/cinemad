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
  <div class="media-item-container" :class="{ 'is-dragging': isDragging }">
    <!-- For images (backdrops/posters) -->
    <div v-if="!isVideo(media)" 
         :class="[
           'media-item-wrapper',
           mediaType === 'posters' ? 'poster' : 'backdrop'
         ]"
         @click="handleImageClick">
      <!-- Skeleton loader that stays until image is loaded -->
      <div v-if="!imageLoaded" class="absolute inset-0 skeleton-loader rounded-md">
        <div class="absolute inset-0 skeleton-shine"></div>
      </div>
      <img :src="media" 
           class="media-item-image" 
           :class="{ 'loaded': imageLoaded }"
           loading="lazy"
           @load="handleImageLoaded"
           @error="handleImageError" />
    </div>
    
    <!-- For videos -->
    <div v-else 
         :class="[
           'media-item-wrapper',
           'backdrop'
         ]">
      <div v-if="!isIframe" 
           class="video-thumbnail-container"
           @click="handleVideoClick">
        <!-- Skeleton loader for video thumbnails -->
        <div v-if="!imageLoaded" class="absolute inset-0 skeleton-loader rounded-md">
          <div class="absolute inset-0 skeleton-shine"></div>
        </div>
        <img :src="getVideoThumbnail(media)" 
             class="media-item-image"
             :class="{ 'loaded': imageLoaded }"
             loading="lazy"
             @load="handleImageLoaded"
             @error="handleImageError" />
        <div class="play-button-overlay">
          <div class="play-button">
            <svg class="play-icon" fill="currentColor" viewBox="0 0 24 24">
              <path d="M8 5v14l11-7z" />
            </svg>
          </div>
        </div>
      </div>
      
      <!-- Video iframe -->
      <div v-else class="iframe-container">
        <iframe 
          :src="getVideoEmbedUrl(media)" 
          class="video-iframe" 
          frameborder="0" 
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
          allowfullscreen>
        </iframe>
        <button 
          @click="handleCloseIframe" 
          class="close-button">
          <svg class="close-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
  width: 300px;
  height: 169px;
}

@media (min-width: 640px) {
  .backdrop {
    width: 480px;
    height: 270px;
  }
}

.poster {
  width: 180px;
  height: 270px;
}

@media (max-width: 639px) {
  .poster {
    width: 120px;
    height: 180px;
  }
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

.video-thumbnail-container {
  position: relative;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

.play-button-overlay {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.play-button {
  width: 3rem;
  height: 3rem;
  border-radius: 9999px;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}

@media (min-width: 640px) {
  .play-button {
    width: 4rem;
    height: 4rem;
  }
}

.play-icon {
  width: 1.5rem;
  height: 1.5rem;
  color: white;
}

@media (min-width: 640px) {
  .play-icon {
    width: 2rem;
    height: 2rem;
  }
}

.iframe-container {
  position: relative;
  width: 100%;
  height: 100%;
}

.video-iframe {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
}

.close-button {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  background-color: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 0.25rem;
  border-radius: 9999px;
  z-index: 10;
}

.close-button:hover {
  background-color: black;
}

.close-icon {
  width: 1rem;
  height: 1rem;
}

@media (min-width: 640px) {
  .close-icon {
    width: 1.25rem;
    height: 1.25rem;
  }
}

.is-dragging {
  cursor: grabbing;
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
</style>