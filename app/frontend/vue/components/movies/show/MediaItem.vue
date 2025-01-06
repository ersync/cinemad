<template>
  <div class="relative w-[533px] h-[300px] rounded-lg overflow-hidden">
    <template v-if="isVideo && !isIframe">
      <div
          class="w-full h-full cursor-pointer"
          @click="$emit('turn-to-iframe')"
      >
        <img
            :src="thumbnailUrl"
            :alt="'Video thumbnail'"
            class="w-full h-full object-cover"
        >
        <div class="absolute inset-0 flex items-center justify-center">
          <div class="w-16 h-16 rounded-full bg-black/75 flex items-center justify-center">
            <svg class="w-8 h-8 text-white">
              <use xlink:href="#play"></use>
            </svg>
          </div>
        </div>
      </div>
    </template>

    <template v-else-if="isVideo && isIframe">
      <iframe
          :src="embedUrl"
          class="w-full h-full"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
      ></iframe>
    </template>

    <template v-else>
      <img
          :src="media"
          :alt="'Movie media'"
          class="w-full h-full object-cover"
      >
    </template>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  media: {
    type: String,
    required: true
  },
  isIframe: {
    type: Boolean,
    default: false
  }
})

defineEmits(['turn-to-iframe'])

const isVideo = computed(() => {
  return props.media.includes('youtube.com') || props.media.includes('vimeo.com')
})

const thumbnailUrl = computed(() => {
  if (props.media.includes('youtube.com')) {
    const videoId = props.media.split('v=')[1]
    return `https://img.youtube.com/vi/${videoId}/hqdefault.jpg`
  }
  // Add Vimeo thumbnail handling if needed
  return props.media
})

const embedUrl = computed(() => {
  if (props.media.includes('youtube.com')) {
    const videoId = props.media.split('v=')[1]
    return `https://www.youtube.com/embed/${videoId}?autoplay=1`
  }
  // Add Vimeo embed handling if needed
  return props.media
})
</script>