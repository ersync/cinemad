<template>
  <Teleport to="body">
    <Transition name="modal-fade">
      <div v-if="isOpen" class="fixed inset-0 bg-slate-900/75 dark:bg-slate-950/90 backdrop-blur-md flex items-center justify-center z-50" @click="closeOnOverlayClick">
        <div class="w-[90%] max-w-[900px] max-h-[85vh] bg-white dark:bg-gray-900 rounded-[20px] shadow-2xl overflow-hidden flex flex-col text-slate-800 dark:text-gray-200 border border-white/10 transition-colors duration-200" @click.stop>
          <!-- Header -->
          <div class="flex justify-between items-center px-5 sm:px-7 py-4 sm:py-6 border-b border-slate-200/60 dark:border-slate-700/30 bg-gradient-to-r from-slate-50 to-slate-100 dark:from-gray-900 dark:to-gray-800">
            <h2 class="text-xl sm:text-2xl font-bold tracking-tight line-clamp-1 bg-gradient-to-r from-indigo-500 to-purple-500 dark:from-indigo-400 dark:to-purple-400 bg-clip-text text-transparent">Reviews for {{ movieData?.title }}</h2>
            <button class="bg-slate-200/50 dark:bg-slate-700/50 text-slate-500 dark:text-slate-400 p-2 sm:p-2.5 rounded-xl flex items-center justify-center transition-all duration-200 hover:bg-slate-300/80 dark:hover:bg-slate-600/70 hover:text-slate-900 dark:hover:text-white hover:scale-105" @click="close">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="sm:w-6 sm:h-6">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </svg>
            </button>
          </div>
          
          <!-- Content -->
          <div class="p-5 sm:p-7 overflow-y-auto flex-1 bg-gradient-to-b from-white to-slate-50 dark:from-gray-900 dark:to-gray-800/90">
            <!-- Stats Section -->
            <div class="flex mb-6 sm:mb-9 bg-gradient-to-r from-indigo-500/5 to-purple-500/5 dark:from-indigo-500/10 dark:to-purple-500/10 rounded-xl p-5 sm:p-7 justify-center border border-indigo-500/10 dark:border-indigo-400/20 shadow-md dark:shadow-indigo-800/5">
              <div class="flex flex-col items-center">
                <div class="w-16 h-16 sm:w-24 sm:h-24 rounded-full bg-conic-gradient flex items-center justify-center mb-3 sm:mb-4 shadow-lg dark:shadow-indigo-700/20 p-1 relative">
                  <div class="w-full h-full rounded-full bg-white dark:bg-gray-900 flex items-center justify-center">
                    <span class="text-2xl sm:text-3xl font-extrabold bg-gradient-to-r from-indigo-500 to-purple-500 dark:from-indigo-400 dark:to-purple-400 bg-clip-text text-transparent">{{ movieData?.average_rating || '?' }}</span>
                  </div>
                </div>
                <p class="text-sm sm:text-base text-slate-500 dark:text-slate-400 font-medium">Average Rating</p>
              </div>
            </div>
            
            <!-- Reviews List -->
            <div class="flex flex-col gap-4 sm:gap-6">
              <!-- Loading State -->
              <div v-if="isReviewsLoading && !reviewsList.length" class="flex flex-col items-center justify-center py-10 bg-gradient-to-r from-white to-slate-50 dark:from-gray-900 dark:to-gray-800 rounded-xl">
                <div class="w-10 h-10 sm:w-12 sm:h-12 border-3 border-indigo-100 dark:border-gray-700 border-t-indigo-500 dark:border-t-indigo-400 rounded-full animate-spin mb-4"></div>
                <p class="text-slate-600 dark:text-slate-400">Loading reviews...</p>
              </div>
              
              <!-- Review Cards -->
              <div v-for="review in reviewsList" :key="review.id" class="bg-white dark:bg-gray-800 rounded-xl p-4 sm:p-6 transition-all duration-300 border border-slate-200/80 dark:border-slate-700/30 shadow-md dark:shadow-gray-900/20 hover:border-indigo-300/30 dark:hover:border-indigo-500/30 relative overflow-hidden">
                <!-- Left accent line -->
                <div class="absolute inset-y-0 left-0 w-1 sm:w-1.5 bg-gradient-to-b from-indigo-500 to-purple-500 dark:from-indigo-400 dark:to-purple-400"></div>
                
                <!-- Header -->
                <div class="flex justify-between items-start mb-4 sm:mb-5">
                  <div class="flex items-center">
                    <div class="w-10 h-10 sm:w-12 sm:h-12 rounded-lg sm:rounded-xl flex items-center justify-center font-bold text-lg sm:text-xl text-white mr-3 sm:mr-4 shadow-md relative overflow-hidden" :style="{ backgroundImage: getAvatarGradient(review.user?.username) }">
                      <div class="absolute inset-0 bg-white/15"></div>
                      <span class="relative z-10">{{ review.user?.username?.charAt(0).toUpperCase() || 'U' }}</span>
                    </div>
                    <div>
                      <h4 class="text-base sm:text-lg font-semibold text-slate-900 dark:text-white mb-0.5 sm:mb-1">{{ review.user?.username || 'Anonymous' }}</h4>
                      <span class="text-xs sm:text-sm text-slate-500 dark:text-slate-400 flex items-center">
                        <span class="inline-block w-1 h-1 bg-slate-300 dark:bg-slate-600 rounded-full mr-1.5"></span>
                        {{ formatDate(review.created_at) }}
                      </span>
                    </div>
                  </div>
                  
                  <!-- Rating -->
                  <div class="flex flex-col items-end">
                    <div v-if="review.rating" class="flex mb-1 sm:mb-1.5">
                      <template v-for="i in 5" :key="i">
                        <span v-if="review.rating >= i * 20" class="ml-0.5 text-amber-500 dark:text-amber-400">
                          <svg viewBox="0 0 24 24" width="14" height="14" class="sm:w-[18px] sm:h-[18px]" fill="currentColor">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                        <span v-else-if="review.rating >= (i - 0.5) * 20" class="ml-0.5 relative">
                          <svg viewBox="0 0 24 24" width="14" height="14" class="sm:w-[18px] sm:h-[18px] text-slate-200 dark:text-slate-700" fill="currentColor">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                          <svg viewBox="0 0 24 24" width="14" height="14" class="sm:w-[18px] sm:h-[18px] absolute inset-0 text-amber-500 dark:text-amber-400" fill="currentColor" style="clip-path: polygon(0 0, 50% 0, 50% 100%, 0 100%);">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                        <span v-else class="ml-0.5 text-slate-200 dark:text-slate-700">
                          <svg viewBox="0 0 24 24" width="14" height="14" class="sm:w-[18px] sm:h-[18px]" fill="currentColor">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                      </template>
                    </div>
                    <span v-if="review.rating" class="text-xs sm:text-sm text-slate-500 dark:text-slate-400 font-medium">{{ review.rating }}/100</span>
                    <span v-else class="bg-gradient-to-r from-cyan-500/10 to-sky-500/10 dark:from-cyan-400/20 dark:to-sky-400/20 text-cyan-600 dark:text-cyan-400 px-2 py-1 sm:px-2.5 sm:py-1.5 rounded-lg text-xs font-semibold tracking-wide border border-cyan-500/20 dark:border-cyan-400/30 text-[10px] sm:text-xs">Not Rated</span>
                  </div>
                </div>
                
                <!-- Content -->
                <div class="relative">
                  <p class="text-slate-700 dark:text-slate-300 text-[0.85rem] sm:text-[0.95rem] leading-relaxed" :class="{ 'max-h-none': expandedReviews.includes(review.id), 'max-h-[300px] overflow-hidden': review.content && review.content.length > 300 && !expandedReviews.includes(review.id) }">
                    {{ review.content }}
                  </p>
                  
                  <div v-if="review.content && review.content.length > 300 && !expandedReviews.includes(review.id)" class="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-white to-transparent dark:from-gray-800 dark:to-transparent pointer-events-none"></div>
                  
                  <div v-if="review.content && review.content.length > 300" class="text-right mt-5 relative z-10">
                    <button @click="toggleFullReview(review.id)" class="bg-indigo-500/10 dark:bg-indigo-500/20 text-indigo-600 dark:text-indigo-400 px-2 py-1 sm:px-3 sm:py-1.5 rounded-lg text-xs sm:text-sm font-medium transition-all duration-200 shadow-sm hover:bg-indigo-500/15 dark:hover:bg-indigo-500/25 hover:-translate-y-0.5 hover:shadow-md">
                      {{ expandedReviews.includes(review.id) ? 'Show Less' : 'Read More' }}
                    </button>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Load More Button -->
            <div v-if="hasMoreReviews && !isReviewsLoading" class="text-center mt-6 sm:mt-9">
              <button @click="loadMoreReviews" class="bg-gradient-to-r from-indigo-500 to-purple-500 dark:from-indigo-600 dark:to-purple-600 text-white px-5 py-2 sm:px-7 sm:py-3 rounded-lg sm:rounded-xl text-sm sm:text-base font-semibold transition-all duration-300 shadow-lg shadow-indigo-500/30 dark:shadow-indigo-700/30 hover:-translate-y-0.5 hover:shadow-xl hover:shadow-indigo-500/40 dark:hover:shadow-indigo-700/40 relative overflow-hidden">
                <span class="relative z-10">Load More Reviews</span>
                <div class="absolute inset-0 -translate-x-full opacity-0 bg-gradient-to-r from-white/20 via-white/0 to-white/0 group-hover:opacity-100 group-hover:translate-x-full transition-all duration-1000"></div>
              </button>
            </div>
            
            <!-- Loading More Indicator -->
            <div v-if="isReviewsLoading && reviewsList.length > 0" class="text-center mt-6 sm:mt-9">
              <button disabled class="bg-gradient-to-r from-slate-400 to-slate-500 dark:from-slate-600 dark:to-slate-700 text-white px-5 py-2 sm:px-7 sm:py-3 rounded-lg sm:rounded-xl text-sm sm:text-base font-semibold opacity-60 cursor-not-allowed">
                Loading more reviews...
              </button>
            </div>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted } from 'vue';
import { useRoute } from 'vue-router';
import { useMovieStore } from '@/vue/stores/movieStore';

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false
  },
  closeOnOutsideClick: {
    type: Boolean,
    default: true
  }
});

const emit = defineEmits(['close', 'loadMore']);

const expandedReviews = ref([]);
const route = useRoute();
const movieStore = useMovieStore();
const movieSlug = computed(() => route.params.slug);

const { data, reviews, isReviewsLoading } = movieStore.movieComputed(movieSlug.value);

const movieData = computed(() => data.value);
const reviewsList = computed(() => reviews.value?.items || []);

const hasMoreReviews = computed(() => {
  if (!reviews.value?.pagination) return false;
  
  const { current_page, total_pages } = reviews.value.pagination;
  return current_page < total_pages;
});

const close = () => {
  emit('close');
};

const closeOnOverlayClick = (event) => {
  if (props.closeOnOutsideClick) {
    close();
  }
};

const formatDate = (dateString) => {
  if (!dateString) return '';
  
  const date = new Date(dateString);
  return new Intl.DateTimeFormat('en-US', { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric' 
  }).format(date);
};

const toggleFullReview = (reviewId) => {
  if (expandedReviews.value.includes(reviewId)) {
    expandedReviews.value = expandedReviews.value.filter(id => id !== reviewId);
  } else {
    expandedReviews.value.push(reviewId);
  }
};

const loadMoreReviews = async () => {
  if (!reviews.value || isReviewsLoading.value) {
    return;
  }
  
  const nextPage = reviews.value.pagination.current_page + 1;
  await movieStore.fetchReviews(movieSlug.value, nextPage);
};

const getAvatarGradient = (username) => {
  if (!username) return 'linear-gradient(135deg, #6366F1, #A855F7)';
  
  const gradients = [
    'linear-gradient(135deg, #6366F1, #A855F7)',
    'linear-gradient(135deg, #14B8A6, #0EA5E9)',
    'linear-gradient(135deg, #F59E0B, #EF4444)',
    'linear-gradient(135deg, #8B5CF6, #EC4899)',
    'linear-gradient(135deg, #10B981, #3B82F6)',
    'linear-gradient(135deg, #F97316, #DB2777)',
    'linear-gradient(135deg, #06B6D4, #6366F1)',
    'linear-gradient(135deg, #84CC16, #22C55E)',
    'linear-gradient(135deg, #EC4899, #8B5CF6)',
    'linear-gradient(135deg, #0D9488, #0369A1)',
    'linear-gradient(135deg, #DC2626, #EA580C)',
    'linear-gradient(135deg, #0891B2, #2563EB)'
  ];
  
  let hash = 0;
  for (let i = 0; i < username.length; i++) {
    hash = username.charCodeAt(i) + ((hash << 5) - hash);
  }
  
  return gradients[Math.abs(hash) % gradients.length];
};

const handleKeyDown = (event) => {
  if (event.key === 'Escape' && props.isOpen) {
    close();
  }
};

onMounted(() => {
  document.addEventListener('keydown', handleKeyDown);
});

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeyDown);
});

watch(() => props.isOpen, (newValue) => {
  if (!newValue) {
    expandedReviews.value = [];
  }
});
</script>

<style scoped>
.bg-conic-gradient {
  background: conic-gradient(from 0deg, #6366F1 0%, #A855F7 50%, #F472B6 100%);
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

.modal-fade-enter-active .review-popup-container {
  animation: slide-in 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

.modal-fade-leave-active .review-popup-container {
  animation: slide-out 0.3s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}

@keyframes slide-in {
  from {
    transform: translateY(30px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes slide-out {
  from {
    transform: translateY(0);
    opacity: 1;
  }
  to {
    transform: translateY(30px);
    opacity: 0;
  }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
</style>