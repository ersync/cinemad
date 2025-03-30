<template>
  <div class="h-[202px] shadow-medium gap-3.5 border border-tmdbLightGray dark:border-gray-700 rounded-lg overflow-hidden flex justify-start items-start mb-5 bg-white dark:bg-gray-800">
    <div class="w-[133px] h-full shrink-0">
      <RouterLink :to="{ name: 'movie-show', params: { slug: movie.slug }}">
        <img :src="movie.cover_url" :alt="movie.title">
      </RouterLink>
    </div>

    <div class="flex flex-col justify-around h-full items-start py-2.5 pr-3.5">
      <div class="flex justify-center items-center gap-2.5">
        <AvgRateBadge
            :average-rating="movie.average_rating"
            size="small-chart"
            :shouldAnimate="false"
        />
        <div>
          <h3 class="font-SourceProBold text-[1.2rem] hover:text-tmdbLighterBlue dark:text-gray-100 dark:hover:text-blue-400 transition-colors leading-5 md:leading-6 line-clamp-1">
            <RouterLink :to="{ name: 'movie-show', params: { slug: movie.slug }}">
              {{ movie.title }}
            </RouterLink>
          </h3>
          <span class="text-black/35 dark:text-gray-400 text-[0.9rem] md:text-base line-clamp-1">
            {{ formatDate(movie.release_date) }}
          </span>
        </div>
      </div>

      <!-- Movie Overview -->
      <div class="mt-3 md:mt-4 leading-5">
        <p class="text-[0.8em] sm:text-base leading-5 line-clamp-3 md:line-clamp-3 dark:text-gray-300">
          {{ movie.overview }}
        </p>
      </div>

      <!-- Movie Actions -->
      <div class="mt-3 md:mt-4 w-full">
        <ul class="flex justify-start gap-2 sm:gap-6 items-center">
          <!-- Rating Stars -->
          <li style="--text-color: #718096;" class="w-[117px] sm:w-[161px]">
            <StarRating
                :movieSlug="movie.slug"
                :rating="userRating"
                :showRatingText="false"
                readonly
            />
          </li>

          <li>
            <button @click="toggleFavorite" class="group relative flex items-center gap-2 transition-all duration-200">
              <span class="w-6 h-6 sm:w-8 sm:h-8 rounded-full flex justify-center items-center
                         transition-all duration-300 transform hover:scale-110"
                    :class="[
                      isFavorite
                        ? 'bg-gradient-to-br from-rose-500 to-pink-600 text-white shadow-lg shadow-rose-500/30 dark:shadow-rose-500/20'
                        : 'bg-gradient-to-br from-rose-50 to-rose-100/80 dark:from-rose-900/30 dark:to-rose-800/30 text-rose-400 dark:text-rose-300'
                    ]">
                <svg class="w-3 h-3 sm:w-3.5 sm:h-3.5" viewBox="0 0 24 24" fill="currentColor">
                  <path v-if="isFavorite"
                        d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
                  <path v-else
                        d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35zM7.5 5C5.5 5 4 6.5 4 8.5c0 2.89 3.14 5.74 8 10.05 4.86-4.31 8-7.16 8-10.05C20 6.5 18.5 5 16.5 5c-1.54 0-3.04.99-3.56 2.36h-1.87C10.54 5.99 9.04 5 7.5 5z"/>
                </svg>
              </span>
              <span class="hidden md:inline text-sm font-medium transition-colors duration-200"
                    :class="isFavorite ? 'text-rose-500 dark:text-rose-400' : 'text-gray-500 dark:text-gray-400'">
                {{ isFavorite ? 'Favorited' : 'Favorite' }}
              </span>
            </button>
          </li>

          <li>
            <button @click="toggleWatchlist" class="group relative flex items-center gap-2 transition-all duration-200">
              <span class="w-6 h-6 sm:w-8 sm:h-8 rounded-full flex justify-center items-center
                         transition-all duration-300 transform hover:scale-110"
                    :class="[
                      inWatchlist
                        ? 'bg-gradient-to-br from-indigo-500 to-purple-600 text-white shadow-lg shadow-purple-500/30 dark:shadow-purple-500/20'
                        : 'bg-gradient-to-br from-indigo-50 to-indigo-100/80 dark:from-indigo-900/30 dark:to-indigo-800/30 text-indigo-400 dark:text-indigo-300'
                    ]">
                <svg class="w-3 h-3 sm:w-3.5 sm:h-3.5" viewBox="0 0 24 24" fill="currentColor">
                  <path v-if="inWatchlist"
                        d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2z"/>
                  <path v-else
                        d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2zm0 15l-5-2.18L7 18V5h10v13z"/>
                </svg>
              </span>
              <span class="hidden md:inline text-sm font-medium transition-colors duration-200"
                    :class="inWatchlist ? 'text-indigo-500 dark:text-indigo-400' : 'text-gray-500 dark:text-gray-400'">
                {{ inWatchlist ? 'In Watchlist' : 'Watchlist' }}
              </span>
            </button>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { RouterLink } from 'vue-router'
import { ref, computed } from 'vue'
import AvgRateBadge from '@/vue/components/movies/shared/AvgRateBadge.vue'
import StarRating from '@/vue/components/movies/shared/StarRating.vue'
import { useAuthStore } from '@/vue/stores/authStore'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'

const props = defineProps({
  movie: {
    type: Object,
    required: true
  }
})

const authStore = useAuthStore()
const interactionStore = useUserInteractionStore()

const interactions = interactionStore.movieInteractionsComputed(props.movie.slug)

const isFavorite = interactions.isFavorite
const inWatchlist = interactions.isInWatchlist
const userRating = interactions.userRating

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric',
    year: 'numeric'
  })
}

const toggleFavorite = async () => {
  if (!authStore.isAuthenticated) {
    alert('Please log in to add to favorites')
    return
  }

  try {
    await interactionStore.toggleFavorite(props.movie.slug)
  } catch (error) {
    console.error('Error toggling favorite:', error)
  }
}

const toggleWatchlist = async () => {
  if (!authStore.isAuthenticated) {
    alert('Please log in to add to watchlist')
    return
  }

  try {
    await interactionStore.toggleWatchlist(props.movie.slug)
    // No need to call fetchInteractions here
  } catch (error) {
    console.error('Error toggling watchlist:', error)
  }
}
</script>