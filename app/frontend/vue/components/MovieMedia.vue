<template>
  <div class="flex flex-col relative mb-[30px] pb-[30px] border-b border-[#d7d7d7]">
    <div
        class="flex [@media(max-width:359px)]:flex-col gap-2 sm:gap-5 justify-between sm:justify-start items-center mb-5 font-SourceProSemiBold antialiased">
      <h2 class="font-SourceProSemiBold text-[1.5rem]">Media</h2>
      <PeriodSelector
          :periods="periods"
          :selected-period="activeTab"
          @period-selected="handlePeriodSelected"
      />
    </div>
    <div class="scrollable-wrapper scrollbar cursor-grab active:cursor-grabbing min-h-[300px] rounded-t-md">
      <div v-cloak class="scrollable-content transition-all duration-500 flex pb-0.5 rounded-lg child:shrink-0">
        <MediaItem
            v-for="(media, index) in mediaUrls"
            :key="index"
            :media="media"
            :isIframe="iframeVideos.includes(index)"
            @turn-to-iframe="turnToIframe(index)"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, onMounted, watch} from 'vue'
import {storeToRefs} from 'pinia'
import {useMovieStore} from '@/vue/stores/movieStore'
import PeriodSelector from '@/vue/components/PeriodSelector.vue'
import MediaItem from '@/vue/components/MediaItem.vue'

const periods = ["Popular Media", "Videos", "Backdrops", "Posters"]
const movieId = ref(null)
const movieStore = useMovieStore()

const mediaUrls = ref([])
const iframeVideos = ref([])
const activeTab = ref('popular_media')

const loadMedia = async (mediaType) => {
  try {
    const urls = await movieStore.fetchMedia(movieId.value, mediaType)
    mediaUrls.value = urls || []
    activeTab.value = mediaType
    iframeVideos.value = []
  } catch (err) {
    console.error('Failed to load media:', err)
  }
}

const handlePeriodSelected = (mediaType) => {
  loadMedia(mediaType)
}

const turnToIframe = (index) => {
  if (!iframeVideos.value.includes(index)) {
    iframeVideos.value.push(index)
  }
}

watch(movieId, async (newMovieId) => {
  if (newMovieId) {
    await loadMedia(activeTab.value)
  }
}, {immediate: true})

onMounted(() => {
  const element = document.getElementById('movie-media')
  if (element) {
    movieId.value = element.dataset.movieId
  }
})
</script>

<style scoped>
</style>