<template>
  <div class="font-SourceProNormal antialiased">
    <!-- Background with overlay -->
    <div class="relative h-[300px] bg-gradient-to-r from-[#032541] to-[#034275] overflow-hidden">

      <!-- Main content -->
      <div class="relative mx-auto max-w-[1420px] h-full">
        <div class="container h-full">
          <div class="flex h-full flex-row justify-center items-center flex-wrap gap-6 sm:gap-8 p-4">
            <!-- Avatar Section -->
            <div class="relative">
              <div class="relative group">
                <div v-if="user.avatar_url"
                     class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white shadow-xl overflow-hidden">
                  <img :src="user.avatar_url"
                       :alt="user.username"
                       class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110">
                </div>
                <div v-else
                     class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white shadow-xl bg-gradient-to-br from-blue-500 to-blue-700 flex items-center justify-center text-[3rem] text-gray-100 sm:text-[4rem] font-bold">
                  {{ user.username[0].toUpperCase() }}
                </div>

                <!-- Edit overlay -->
                <div v-if="isCurrentUser"
                     class="absolute inset-0 bg-black/40 rounded-full opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center cursor-pointer">
                  <span class="text-white text-sm font-medium">Change Photo</span>
                </div>
              </div>
            </div>

            <!-- User Info Section -->
            <div class="flex-1 text-white">
              <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4 mb-4">
                <h2 class="text-3xl sm:text-4xl font-bold tracking-tight line-clamp-1">
                  {{ user.username }}
                </h2>
                <div class="flex items-center gap-3">
                  <span class="px-3 py-1 rounded-full bg-white/10 text-xs sm:text-sm">
                    Member since {{ formatDate(user.created_at) }}
                  </span>
                </div>
              </div>

              <!-- Stats Section -->
              <div class="flex flex-wrap gap-6 text-white/90">
                <div class="flex items-center gap-3">
                  <div class="hidden sm:block">
                    <AvgRateBadge
                        :average-rating="user.avg_rating"
                        size="big-chart"
                        class="transform hover:scale-110 transition-transform"
                    />
                  </div>
                  <div class="sm:hidden">
                    <AvgRateBadge
                        :average-rating="user.avg_rating"
                        size="small-chart"
                        class="transform hover:scale-110 transition-transform"
                    />
                  </div>
                  <div class="text-xs sm:text-base">
                    <div class="font-medium">Average Rating</div>
                    <div class="text-white/70">from {{user.stats?.total_ratings || 0 }} ratings</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { RouterLink } from 'vue-router'
import AvgRateBadge from '@/vue/components/movies/shared/AvgRateBadge.vue'

const props = defineProps({
  user: {
    type: Object,
    required: true
  },
  isCurrentUser: {
    type: Boolean,
    default: false
  }
})

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    month: 'long',
    year: 'numeric'
  })
}
</script>

<style scoped>
</style>