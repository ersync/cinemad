<template>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
    <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275] dark:text-indigo-400">{{ user.stats?.total_reviews || 0 }}</span>
        <span class="text-sm text-gray-600 dark:text-gray-400 mt-1">Reviews</span>
      </div>
    </div>
    <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275] dark:text-indigo-400">{{ user.stats?.total_ratings || 0 }}</span>
        <span class="text-sm text-gray-600 dark:text-gray-400 mt-1">Ratings</span>
      </div>
    </div>
    <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275] dark:text-indigo-400">{{ user.stats?.total_favorites || 0 }}</span>
        <span class="text-sm text-gray-600 dark:text-gray-400 mt-1">Favorites</span>
      </div>
    </div>
    <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275] dark:text-indigo-400">{{ watchlistCount }}</span>
        <span class="text-sm text-gray-600 dark:text-gray-400 mt-1">In-Watchlist</span>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  user: {
    type: Object,
    required: true
  },
  watchlistCount: {
    type: Number,
    required: true
  }
})
</script>