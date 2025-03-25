<template>
  <Teleport to="body">
    <Transition name="modal-fade">
      <div v-if="isOpen" class="review-popup-overlay" @click="closeOnOverlayClick">
        <div class="review-popup-container" @click.stop>
          <div class="review-popup-header">
            <h2 class="line-clamp-1">Reviews for {{ movieData?.title }}</h2>
            <button class="close-button" @click="close">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </svg>
            </button>
          </div>
          
          <div class="review-popup-content">
            <div class="review-stats">
              <div class="average-rating">
                <div class="rating-circle">
                  <div class="inner-circle">
                    <span>{{ movieData?.average_rating || '?' }}</span>
                  </div>
                </div>
                <p>Average Rating</p>
              </div>
            </div>
            
            <div class="reviews-list">
              <div v-if="isReviewsLoading && !reviewsList.length" class="review-card loading">
                <div class="loading-spinner"></div>
                <p>Loading reviews...</p>
              </div>
              
              <div v-for="review in reviewsList" :key="review.id" class="review-card">
                <div class="review-card-header">
                  <div class="reviewer-info">
                    <div class="avatar" :style="{ backgroundImage: getAvatarGradient(review.user?.username) }">
                      {{ review.user?.username?.charAt(0).toUpperCase() || 'U' }}
                    </div>
                    <div class="reviewer-details">
                      <h4>{{ review.user?.username || 'Anonymous' }}</h4>
                      <span class="review-date">{{ formatDate(review.created_at) }}</span>
                    </div>
                  </div>
                  <div class="review-rating">
                    <div v-if="review.rating" class="stars">
                      <template v-for="i in 5" :key="i">
                        <span v-if="review.rating >= i * 20" class="star filled">
                          <svg viewBox="0 0 24 24" width="18" height="18">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                        <span v-else-if="review.rating >= (i - 0.5) * 20" class="star half-filled">
                          <svg viewBox="0 0 24 24" width="18" height="18">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                        <span v-else class="star">
                          <svg viewBox="0 0 24 24" width="18" height="18">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                          </svg>
                        </span>
                      </template>
                    </div>
                    <span v-if="review.rating" class="rating-value">{{ review.rating }}/100</span>
                    <span v-else class="not-rated-badge">Not Rated</span>
                  </div>
                </div>
                <div class="review-card-content">
                  <p :class="{ 'expanded': expandedReviews.includes(review.id) }">{{ review.content }}</p>
                  <div v-if="review.content && review.content.length > 300" class="read-more">
                    <button @click="toggleFullReview(review.id)">
                      {{ expandedReviews.includes(review.id) ? 'Show Less' : 'Read More' }}
                    </button>
                  </div>
                </div>
              </div>
            </div>
            
            <div v-if="hasMoreReviews && !isReviewsLoading" class="load-more">
              <button @click="loadMoreReviews">Load More Reviews</button>
            </div>
            
            <div v-if="isReviewsLoading && reviewsList.length > 0" class="load-more">
              <button disabled>Loading more reviews...</button>
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

const shouldShowGradient = (reviewId) => {
  const review = reviewsList.value.find(r => r.id === reviewId);
  return !expandedReviews.value.includes(reviewId) && 
         review?.content?.length > 300;
};

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
.review-popup-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(15, 23, 42, 0.75);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  backdrop-filter: blur(10px);
}

.review-popup-container {
  width: 90%;
  max-width: 900px;
  max-height: 85vh;
  background-color: #ffffff;
  border-radius: 20px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  display: flex;
  flex-direction: column;
  color: #1e293b;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.review-popup-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 28px;
  border-bottom: 1px solid rgba(226, 232, 240, 0.6);
  background: linear-gradient(to right, #f1f5f9, #f8fafc);
}

.review-popup-header h2 {
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0;
  background: linear-gradient(135deg, #6366F1, #A855F7);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  letter-spacing: -0.025em;
}

.close-button {
  background: rgba(226, 232, 240, 0.5);
  border: none;
  color: #64748b;
  cursor: pointer;
  padding: 10px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.close-button:hover {
  background-color: rgba(203, 213, 225, 0.8);
  color: #0f172a;
  transform: scale(1.05);
}

.review-popup-content {
  padding: 28px;
  overflow-y: auto;
  flex: 1;
  background: linear-gradient(to bottom, #ffffff, #f8fafc);
}

.review-stats {
  display: flex;
  margin-bottom: 36px;
  background: linear-gradient(to right, rgba(99, 102, 241, 0.05), rgba(168, 85, 247, 0.05));
  border-radius: 16px;
  padding: 28px;
  justify-content: center;
  border: 1px solid rgba(99, 102, 241, 0.1);
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
}

.average-rating {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.rating-circle {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: conic-gradient(from 0deg, #6366F1 0%, #A855F7 50%, #F472B6 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
  position: relative;
  box-shadow: 0 15px 30px -10px rgba(99, 102, 241, 0.4);
  padding: 4px;
}

.inner-circle {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
}

.rating-circle span {
  font-size: 2rem;
  font-weight: 800;
  background: linear-gradient(135deg, #6366F1, #A855F7);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.average-rating p {
  font-size: 1rem;
  color: #64748b;
  margin: 0;
  font-weight: 500;
}

.reviews-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.review-card {
  background-color: #ffffff;
  border-radius: 16px;
  padding: 24px;
  transition: all 0.3s ease;
  border: 1px solid rgba(226, 232, 240, 0.8);
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
  position: relative;
  overflow: hidden;
}

.review-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 6px;
  height: 100%;
  background: linear-gradient(to bottom, #6366F1, #A855F7);
  border-top-left-radius: 16px;
  border-bottom-left-radius: 16px;
}

.review-card:hover {
  border-color: rgba(99, 102, 241, 0.3);
}

.review-card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
}

.reviewer-info {
  display: flex;
  align-items: center;
}

.avatar {
  width: 48px;
  height: 48px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.3rem;
  margin-right: 16px;
  color: white;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  position: relative;
  overflow: hidden;
}

.avatar::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.15);
  border-radius: inherit;
}

.reviewer-details h4 {
  margin: 0 0 4px 0;
  font-size: 1.1rem;
  font-weight: 600;
  color: #0f172a;
}

.review-date {
  font-size: 0.85rem;
  color: #64748b;
  display: inline-flex;
  align-items: center;
}

.review-date::before {
  content: '';
  display: inline-block;
  width: 4px;
  height: 4px;
  background-color: #cbd5e1;
  border-radius: 50%;
  margin-right: 6px;
}

.review-rating {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.stars {
  display: flex;
  margin-bottom: 6px;
}

.star {
  margin-left: 2px;
  position: relative;
  display: flex;
}

.star svg {
  fill: #e2e8f0;
  stroke: none;
  transition: all 0.2s ease;
}

.star.filled svg {
  fill: #f59e0b;
  filter: drop-shadow(0 0 2px rgba(245, 158, 11, 0.3));
}

.star.half-filled {
  position: relative;
}

.star.half-filled svg {
  position: relative;
  z-index: 1;
  clip-path: polygon(0 0, 50% 0, 50% 100%, 0 100%);
  fill: #f59e0b;
}

.star.half-filled::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" fill="%23e2e8f0"/></svg>');
  background-size: 18px 18px;
  background-repeat: no-repeat;
  z-index: 0;
}

.rating-value {
  font-size: 0.85rem;
  color: #64748b;
  font-weight: 500;
}

.not-rated-badge {
  background: linear-gradient(to right, rgba(56, 189, 248, 0.1), rgba(6, 182, 212, 0.1));
  color: #0891b2;
  padding: 5px 10px;
  border-radius: 8px;
  font-size: 0.8rem;
  font-weight: 600;
  letter-spacing: 0.025em;
  border: 1px solid rgba(6, 182, 212, 0.2);
}

.review-card-content {
  margin-bottom: 16px;
  position: relative;
}

.review-card-content p {
  margin: 0;
  line-height: 1.7;
  color: #334155;
  font-size: 0.95rem;
  position: relative;
}

.review-card-content p:not(.expanded) {
  max-height: 300px;
  overflow: hidden;
}

.review-card-content p:not(.expanded) + .read-more::before {
  content: '';
  position: absolute;
  bottom: 40px;
  left: 0;
  right: 0;
  height: 60px;
  background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1));
  pointer-events: none;
}

.read-more {
  text-align: right;
  margin-top: 12px;
}

.read-more button {
  background: rgba(99, 102, 241, 0.1);
  border: none;
  color: #6366f1;
  cursor: pointer;
  font-size: 0.9rem;
  padding: 6px 12px;
  border-radius: 8px;
  font-weight: 500;
  transition: all 0.2s ease;
  box-shadow: 0 2px 4px rgba(99, 102, 241, 0.1);
}

.read-more button:hover {
  background-color: rgba(99, 102, 241, 0.15);
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(99, 102, 241, 0.15);
}

.load-more {
  text-align: center;
  margin-top: 36px;
}

.load-more button {
  background: linear-gradient(to right, #6366f1, #8b5cf6);
  border: none;
  color: white;
  padding: 12px 28px;
  border-radius: 12px;
  cursor: pointer;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.3);
  position: relative;
  overflow: hidden;
  letter-spacing: 0.025em;
}

.load-more button::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.load-more button:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 15px 25px -5px rgba(99, 102, 241, 0.4);
}

.load-more button:hover:not(:disabled)::after {
  opacity: 1;
}

.load-more button:active:not(:disabled) {
  transform: translateY(-1px);
}

.load-more button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  background: linear-gradient(to right, #94a3b8, #cbd5e1);
  box-shadow: none;
}

.review-card.loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  background: linear-gradient(to right, #ffffff, #f8fafc);
}

.loading-spinner {
  width: 48px;
  height: 48px;
  border: 3px solid rgba(99, 102, 241, 0.1);
  border-radius: 50%;
  border-top-color: #6366f1;
  animation: spin 1s cubic-bezier(0.65, 0, 0.35, 1) infinite;
  margin-bottom: 16px;
  filter: drop-shadow(0 4px 6px rgba(99, 102, 241, 0.1));
}

@keyframes spin {
  to { transform: rotate(360deg); }
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

@media (max-width: 768px) {
  .review-popup-header {
    padding: 20px 24px;
  }
  
  .review-popup-content {
    padding: 24px;
  }
  
  .rating-circle {
    width: 80px;
    height: 80px;
  }
  
  .rating-circle span {
    font-size: 1.7rem;
  }
  
  .review-card {
    padding: 20px;
  }
}

@media (max-width: 540px) {
  .review-popup-header {
    padding: 16px 20px;
  }
  
  .review-popup-header h2 {
    font-size: 1.2rem;
  }
  
  .review-popup-content {
    padding: 16px;
  }
  
  .review-stats {
    padding: 16px;
    margin-bottom: 20px;
  }
  
  .rating-circle {
    width: 65px;
    height: 65px;
  }
  
  .rating-circle span {
    font-size: 1.3rem;
  }
  
  .average-rating p {
    font-size: 0.85rem;
  }
  
  .avatar {
    width: 36px;
    height: 36px;
    font-size: 1rem;
    margin-right: 10px;
    border-radius: 10px;
  }
  
  .reviewer-details h4 {
    font-size: 0.9rem;
  }
  
  .review-date {
    font-size: 0.75rem;
  }
  
  .review-card {
    padding: 14px;
    border-radius: 12px;
  }
  
  .review-card-content p {
    font-size: 0.85rem;
    line-height: 1.6;
  }
  
  .star svg {
    width: 16px;
    height: 16px;
  }
  
  .rating-value {
    font-size: 0.75rem;
  }
  
  .not-rated-badge {
    font-size: 0.7rem;
    padding: 4px 8px;
  }
  
  .read-more button {
    font-size: 0.8rem;
    padding: 5px 10px;
  }
  
  .load-more {
    margin-top: 24px;
  }
  
  .load-more button {
    padding: 10px 20px;
    font-size: 0.85rem;
    border-radius: 10px;
  }
  
  .loading-spinner {
    width: 36px;
    height: 36px;
    border-width: 2px;
  }
}
</style>