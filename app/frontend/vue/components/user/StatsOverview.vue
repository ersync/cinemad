<template>
  <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
    <div class="bg-white rounded-xl p-6 shadow-sm">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275]">{{ user.stats?.total_reviews || 0 }}</span>
        <span class="text-sm text-gray-600 mt-1">Reviews</span>
      </div>
    </div>
    <div class="bg-white rounded-xl p-6 shadow-sm">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275]">{{ user.stats?.total_ratings || 0 }}</span>
        <span class="text-sm text-gray-600 mt-1">Ratings</span>
      </div>
    </div>
    <div class="bg-white rounded-xl p-6 shadow-sm">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275]">{{ user.stats?.total_favorites || 0 }}</span>
        <span class="text-sm text-gray-600 mt-1">Favorites</span>
      </div>
    </div>
    <div class="bg-white rounded-xl p-6 shadow-sm">
      <div class="flex flex-col items-center">
        <span class="text-3xl font-bold text-[#034275]">{{ watchlistCount }}</span>
        <span class="text-sm text-gray-600 mt-1">In-Watchlist</span>
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