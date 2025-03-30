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

const castMembers = computed(() => {
  if (movieData.value?.cast?.cast && Array.isArray(movieData.value.cast.cast)) {
    return movieData.value.cast.cast.map(member => ({
      id: member.id || `temp-${Math.random()}`,
      name: member.name || 'Unknown',
      image_url: member.image_url || '/path/to/default/image.jpg',
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