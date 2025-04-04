<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import CastList from './CastList.vue'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)

const { data: movieData, isLoading: storeLoading } = movieStore.movieComputed(movieSlug.value)
const isLoading = ref(true)
const imagesLoaded = ref(0)
const totalImagesToLoad = ref(0)

const defaultAvatar = 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(`
  <svg xmlns="http://www.w3.org/2000/svg" shape-rendering="geometricPrecision" text-rendering="geometricPrecision" image-rendering="optimizeQuality" fill-rule="evenodd" clip-rule="evenodd" viewBox="0 0 512 512"><path fill="#D0D0D0" d="M0 0h512v512H0z"/><path fill="#B1B1B1" d="M86.655 416.22c7.264-94.069 37.323-70.129 106.837-113.622 21.47 44.795 108.726 48.051 126.619 0 59.99 38.35 105.701 16.656 105.23 113.622H86.655zm123.222-117.155c-.926-1.202 2.423-9.452 3.216-10.787-9.081-8.081-16.258-16.235-17.788-33.013l-.973.02c-2.249-.03-4.418-.547-6.449-1.704-3.252-1.85-5.539-5.025-7.084-8.606-3.27-7.514-14.042-32.452 2.37-30.481-9.177-17.137 11.592-46.413-24.228-57.241 29.389-37.222 91.398-94.614 136.841-37.044 49.739 4.82 65.255 63.932 31.762 96.307 1.962.071 3.811.523 5.448 1.399 6.226 3.335 6.43 10.574 4.794 16.646-1.619 5.073-3.676 8.505-5.614 13.45-2.359 6.676-5.806 7.919-12.467 7.2-.338 16.507-7.967 24.609-18.233 34.307l2.809 9.517c-13.767 29.202-70.958 30.377-94.404.03z"/></svg>
`);

const castMembers = computed(() => {
  if (movieData.value?.cast?.cast && Array.isArray(movieData.value.cast.cast)) {
    return movieData.value.cast.cast.map(member => ({
      id: member.id || `temp-${Math.random()}`,
      name: member.name || 'Unknown',
      image_url: member.image_url || defaultAvatar,
      character_names: Array.isArray(member.character_names) ? member.character_names : []
    }))
  }
  return []
})

const handleImageLoaded = () => {
  imagesLoaded.value++
  if (imagesLoaded.value >= Math.min(totalImagesToLoad.value, 10)) {
    isLoading.value = false
  }
}

const preloadCastImages = () => {
  if (castMembers.value.length > 0 && storeLoading.value === false) {
    const castToPreload = castMembers.value.slice(0, 10)
    totalImagesToLoad.value = castToPreload.length
    
    imagesLoaded.value = 0
    isLoading.value = true
    
    castToPreload.forEach(member => {
      const img = new Image()
      img.onload = handleImageLoaded
      img.onerror = handleImageLoaded
      img.src = member.image_url
    })
    
    setTimeout(() => {
      isLoading.value = false
    }, 3000)
  }
}

watch(() => castMembers.value, (newCast) => {
  if (newCast.length > 0) {
    preloadCastImages()
  }
}, { immediate: true })

onMounted(() => {
  if (castMembers.value.length > 0) {
    preloadCastImages()
  }
})

defineEmits(['showFullCast'])
</script>

<template>
  <div class="mb-10 antialiased min-h-[320px]">
    <div class="relative">
      <SectionHeading title="Featured Cast" />
      <div class="mt-6">
        <div v-if="isLoading" class="font-SourceProNormal scrollbar overflow-x-auto">
          <ul class="flex gap-3.5 mb-2.5 h-[268px]">
            <li v-for="n in 10" :key="n" class="animate-pulse">
              <div class="w-[100px] sm:w-[140px] overflow-hidden rounded-lg 
                          border border-gray-200/90 dark:border-gray-700/80
                          mb-2.5 pb-2.5 
                          shadow-[2px_8px_20px_rgb(0,0,0,0.02)] dark:shadow-[2px_8px_20px_rgb(0,0,0,0.1)]
                          bg-white/80 dark:bg-gray-800/90 backdrop-blur-sm">
                <div class="h-[147px] sm:h-[207px] bg-gray-200 dark:bg-gray-700 rounded-t-lg"></div>
                <div class="mt-3 mx-2.5 space-y-2">
                  <div class="h-4 bg-gray-200 dark:bg-gray-700 rounded w-3/4"></div>
                  <div class="h-3 bg-gray-200 dark:bg-gray-700 rounded w-1/2"></div>
                </div>
              </div>
            </li>
          </ul>
        </div>
        
        <!-- Actual content -->
        <CastList
            v-else
            :cast="castMembers"
            class="mb-5"
            @image-loaded="handleImageLoaded"
        />
      </div>
    </div>
  </div>
</template>