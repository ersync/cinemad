<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"
import FeaturedReview from './FeaturedReview.vue'

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)

const { data: movieData, isLoading } = movieStore.movieComputed(movieSlug.value)

const reviewData = computed(() => {
  return movieData.value?.reviews_section || null
})

const featuredReview = computed(() => {
  return reviewData.value?.featured_review || null
})

const totalReviews = computed(() => {
  return reviewData.value?.stats?.total_count || 0
})

</script>

<template>
  <div class="mb-10 antialiased bg-white/95 backdrop-blur-lg transition-all duration-200">
    <SectionHeading
        title="Reviews"
        :counter="totalReviews"
    />

    <FeaturedReview
        v-if="featuredReview"
        :review="featuredReview"
        class="mb-12 animate-fade-in mt-6"
    />

    <div
        v-else-if="!isLoading"
        class="text-center py-12 px-6 bg-gradient-to-br from-gray-50/50 to-white/80 rounded-2xl text-gray-900"
    >
      <h3 class="text-2xl font-semibold mb-3 text-[#034275]">
        No Reviews Yet
      </h3>
      <p class="text-gray-500 text-base leading-relaxed">
        Share your thoughts on this movie
      </p>
    </div>
  </div>
</template>

<style scoped>
@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fade-in 0.3s ease;
}
</style>