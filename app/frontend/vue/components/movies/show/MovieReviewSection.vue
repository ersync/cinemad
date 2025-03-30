<script setup>
import { ref, computed, provide } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"
import FeaturedReview from './FeaturedReview.vue'
import MovieReviewsPopup from './MovieReviewsPopup.vue'

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)

const { data: movieData, isLoading, reviewSection, reviews } = movieStore.movieComputed(movieSlug.value)


const featuredReview = computed(() => {
  return reviewSection.value?.featured_review || 
         reviewSection.value?.review_section?.featured_review || 
         null
})

const totalReviews = computed(() => {
  if (reviews.value?.items?.length > 0) {
    return reviews.value.pagination.total_count || reviews.value.items.length
  }
  
  return reviewSection.value?.stats?.total_count || 
         reviewSection.value?.review_section?.stats?.total_count || 
         0
})

const isReviewsPopupOpen = ref(false)

const openReviewsPopup = () => {
  isReviewsPopupOpen.value = true
}

const closeReviewsPopup = () => {
  isReviewsPopupOpen.value = false
}

provide('openReviewsPopup', openReviewsPopup)


const loadMoreReviews = async (page) => {
  await movieStore.fetchReviews(movieSlug.value, page)
}
</script>

<template>
  <section class="mb-10">
    <div class="flex justify-between items-center mb-8 antialiased transition-all duration-200">
      <SectionHeading title="Reviews" />
    
      <div class="flex justify-between items-center">
        <div class="flex-1"></div>
        <div class="relative">
          <button 
            @click="openReviewsPopup"
            class="group inline-flex items-center px-4 py-2.5 sm:px-6 sm:py-3
                   bg-white/90 dark:bg-gray-800/90
                   text-indigo-600 dark:text-indigo-400 font-medium
                   rounded-2xl
                   transition-all duration-300
                   relative"
          >
            <span class="absolute inset-0 rounded-2xl border-2 border-transparent 
                        bg-gradient-to-r from-indigo-500 to-purple-600 dark:from-indigo-600 dark:to-purple-700 
                        opacity-70 -z-10"
                  style="mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                         mask-composite: exclude;
                         -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                         -webkit-mask-composite: source-out;"></span>
            
            <span class="absolute inset-0 rounded-2xl 
                        bg-gradient-to-r from-indigo-500/20 to-purple-600/20 dark:from-indigo-600/30 dark:to-purple-700/30 
                        blur-lg opacity-50 -z-20"></span>
            
            <span class="relative text-xs sm:text-base">
              All Reviews
              <span class="absolute -bottom-0.5 left-0 w-full h-0.5 
                         bg-gradient-to-r from-indigo-500 to-purple-500 dark:from-indigo-400 dark:to-purple-400 
                         transform scale-x-0 origin-left group-hover:scale-x-100 transition-transform duration-300"></span>
            </span>
            <span class="ml-2 bg-indigo-100 dark:bg-indigo-900/60 text-indigo-700 dark:text-indigo-200 
                      rounded-full px-2 py-0.5 text-[9px] sm:text-sm font-semibold">
              {{ totalReviews }}
            </span>
          </button>
        </div>
      </div>
    </div>
    
    <FeaturedReview
        v-if="featuredReview"
        :review="featuredReview"
        class="animate-fade-in"
    />
    
    <div
        v-else-if="!isLoading"
        class="text-center py-12 px-6 
               bg-gradient-to-br from-gray-50/50 to-white/80 dark:from-gray-800/50 dark:to-gray-900/80 
               rounded-2xl text-gray-900 dark:text-gray-100"
    >
      <h3 class="text-2xl font-semibold mb-3 text-[#034275] dark:text-indigo-300">
        No Reviews Yet
      </h3>
      <p class="text-gray-500 dark:text-gray-400 text-base leading-relaxed">
        Share your thoughts on this movie
      </p>
    </div>
    
    <MovieReviewsPopup 
      :is-open="isReviewsPopupOpen"
      @close="closeReviewsPopup"
      @load-more="loadMoreReviews"
    />
  </section>
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