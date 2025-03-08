<script setup>
import { computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import CastSkeleton from './CastSkeleton.vue'
import CastList from './CastList.vue'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)

const { data: movieData, isLoading } = movieStore.movieComputed(movieSlug.value)

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

defineEmits(['showFullCast'])
</script>

<template>
  <div class="mb-12 antialiased min-h-[320px]">
    <div class="relative">
      <SectionHeading title="Featured Cast" />
      <div class="mt-6">
        <CastSkeleton v-if="isLoading" />
        <CastList
            v-else
            :cast="castMembers"
            class="mb-5"
        />
      </div>
    </div>
  </div>
</template>