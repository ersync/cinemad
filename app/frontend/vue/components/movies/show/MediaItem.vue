<script setup>
import { computed, ref } from 'vue'
const props = defineProps({
  media: {
    type: String,
    required: true
  },
  isIframe: {
    type: Boolean,
    default: false
  },
  isDragging: {
    type: Boolean,
    default: false
  }
})
const mouseDownTime = ref(0)
const emit = defineEmits(['turn-to-iframe', 'close-iframe', 'open-lightbox'])
const isVideo = computed(() => {
  return props.media.includes('youtube.com') || props.media.includes('vimeo.com')
})
const thumbnailUrl = computed(() => {
  if (props.media.includes('youtube.com')) {
    const videoId = props.media.split('v=')[1]
    return `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`
  }
  return props.media
})
const embedUrl = computed(() => {
  if (props.media.includes('youtube.com')) {
    const videoId = props.media.split('v=')[1]
    return `https://www.youtube.com/embed/${videoId}?autoplay=1`
  }
  return props.media
})
const handleClick = () => {
  const clickDuration = Date.now() - mouseDownTime.value
  if (!props.isDragging && clickDuration < 200) {
    emit('turn-to-iframe')
  }
}
const closeIframe = () => {
  emit('close-iframe')
}
const openLightbox = () => {
  if (!props.isDragging) {
    emit('open-lightbox', props.media)
  }
}
</script>
<template>
  <div class="select-none media-item relative h-[300px] overflow-hidden rounded-md
              group w-auto">
    <template v-if="isVideo && !isIframe">
      <div class="w-full h-full cursor-pointer"
           @click="handleClick"
           @mousedown="mouseDownTime = Date.now()">
        <img :src="thumbnailUrl"
             :alt="'Video thumbnail'"
             class="w-full h-full object-cover transition-transform duration-500
                    ">
        <div class="absolute inset-0 bg-black/30 group-hover:bg-black/40
                    transition-all duration-300 flex items-center justify-center">
          <div class="transform">
            <div class="w-16 h-16 rounded-full bg-white/90 group-hover:bg-white
                        flex items-center justify-center shadow-lg
                        group-hover:shadow-xl transition-all duration-300">
              <svg class="w-8 h-8 text-black fill-current ml-1" viewBox="0 0 24 24">
                <path d="M8 5v14l11-7z"/>
              </svg>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template v-else-if="isVideo && isIframe">
      <div class="relative w-full h-full">
        <iframe :src="embedUrl"
                class="w-full h-full"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media;
                       gyroscope; picture-in-picture"
                allowfullscreen>
        </iframe>
        <button @click="closeIframe"
                class="absolute top-2 right-2 bg-black/70 hover:bg-black/90
                       p-1.5 rounded-full transition-colors duration-200">
          <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor"
               viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>
    </template>
    <template v-else>
      <div class="relative w-full h-full group cursor-pointer"
           @click="openLightbox">
        <img :src="props.media"
             alt="Movie media"
             class="w-full h-full object-cover transition-transform duration-500
                   ">
      </div>
    </template>
  </div>
</template>
<style scoped>
.media-item {
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
}
.media-item:hover {
  box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
}
</style>