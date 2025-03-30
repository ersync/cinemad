<template>
  <div v-if="userProfile" class="bg-gray-50 dark:bg-gray-900 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Stats Overview -->
      <StatsOverview
          :user="userProfile"
          :watchlist-count="userProfile.stats.total_watchlist"
      />

      <!-- Watchlist Section -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm dark:shadow-gray-900/20 p-6 mb-8">
        <div class="flex justify-between items-center mb-6">
          <h3 class="text-xl font-bold text-gray-900 dark:text-gray-100">Watchlist</h3>
          <RouterLink
              :to="{ name: 'userWatchlist', params: { username: userProfile.username }}"
              class="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 font-medium text-sm"
          >
            View All
          </RouterLink>
        </div>

        <WatchlistPreview
            :watchlist="watchlistMovies"
            :visible-movies="visibleMovies"
            :max-visible-cards="maxVisibleCards"
            @update-visible-cards="handleVisibleCardsUpdate"
        />
      </div>

      <!-- Ratings Overview -->
      <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm dark:shadow-gray-900/20 p-6 mb-8">
        <div class="flex justify-between items-center mb-6">
          <h3 class="text-xl font-bold text-gray-900 dark:text-gray-100">Ratings Overview</h3>
          <RouterLink
              :to="{ name: 'userRatings', params: { username: userProfile.username }}"
              class="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 font-medium text-sm"
          >
            View All
          </RouterLink>
        </div>

        <RatingsOverview :user="userProfile" />
      </div>

      <RecentActivity :activities="recentActivity" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { RouterLink } from 'vue-router'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import StatsOverview from '@/vue/components/user/StatsOverview.vue'
import WatchlistPreview from '@/vue/components/user/WatchlistPreview.vue'
import RatingsOverview from '@/vue/components/user/RatingsOverview.vue'
import RecentActivity from '@/vue/components/user/RecentActivity.vue'

const interactionStore = useUserInteractionStore()

const recentActivity = ref([])
const maxVisibleCards = ref(2)

const userProfile = computed(() => interactionStore.userProfileComputed)
const watchlistMovies = computed(() => interactionStore.listComputed('watchlist').movies.value)

const visibleMovies = computed(() => {
  return watchlistMovies.value.slice(0, maxVisibleCards.value)
})

const handleVisibleCardsUpdate = (newValue) => {
  maxVisibleCards.value = newValue
}

</script>