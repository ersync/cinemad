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

<template>
  <div class="font-SourceProNormal antialiased">
    <!-- Background with overlay -->
  <div class="relative h-[300px] bg-gradient-to-r from-[#032541] to-[#034275] dark:from-[#010108] dark:via-[#111a4b] dark:to-[#0a0118] overflow-hidden">
      <!-- Dark mode animated particles -->
      <div class="absolute inset-0 w-full h-full dark:block hidden">
        <div class="stars-container">
          <div class="stars"></div>
          <div class="stars2"></div>
          <div class="shooting-stars"></div>
          <div class="shooting-star-extra"></div>
          <div class="shooting-star-extra2"></div>
        </div>
      </div>

      <!-- Main content -->
      <div class="relative mx-auto max-w-[1420px] h-full">
        <div class="container h-full">
          <div class="flex h-full flex-row justify-center items-center flex-wrap gap-6 sm:gap-8 p-4">
            <!-- Avatar Section -->
            <div class="relative">
              <div class="relative group">
                <div v-if="user.avatar_url"
                     class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white dark:ring-indigo-500/30 shadow-xl overflow-hidden">
                  <img :src="user.avatar_url"
                       :alt="user.username"
                       class="w-full h-full object-cover transition-transform duration-300 group-hover:scale-110">
                </div>
                <div v-else
                     class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white dark:ring-indigo-500/30 shadow-xl bg-gradient-to-br from-blue-500 to-blue-700 dark:from-indigo-600 dark:to-purple-800 flex items-center justify-center text-[3rem] text-gray-100 sm:text-[4rem] font-bold">
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
                  <span class="px-3 py-1 rounded-full bg-white/10 dark:bg-white/5 text-xs sm:text-sm">
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

<style scoped>
.stars-container {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  transform: translateZ(0);
}

.stars, .stars2 {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: 
    radial-gradient(2px 2px at 20px 30px, #edf2f7, rgba(0,0,0,0)),
    radial-gradient(2px 2px at 40px 70px, #f7fafc, rgba(0,0,0,0)),
    radial-gradient(1px 1px at 90px 40px, #e2e8f0, rgba(0,0,0,0)),
    radial-gradient(2px 2px at 160px 120px, #edf2f7, rgba(0,0,0,0)),
    radial-gradient(1px 1px at 230px 50px, #f7fafc, rgba(0,0,0,0));
  background-repeat: repeat;
  background-size: 250px 250px;
  opacity: 0.15;
  animation: stars-move 100s linear infinite;
}

.stars2 {
  background-image: 
    radial-gradient(1px 1px at 25px 5px, #edf2f7, rgba(0,0,0,0)),
    radial-gradient(1px 1px at 50px 25px, #f7fafc, rgba(0,0,0,0)),
    radial-gradient(1px 1px at 125px 20px, #e2e8f0, rgba(0,0,0,0)),
    radial-gradient(1.5px 1.5px at 190px 90px, #edf2f7, rgba(0,0,0,0)),
    radial-gradient(1.5px 1.5px at 200px 60px, #f7fafc, rgba(0,0,0,0));
  background-size: 200px 200px;
  animation-delay: 50ms;
}

.shooting-stars {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.shooting-stars::before, .shooting-stars::after {
  content: "";
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
}

.shooting-stars::before {
  animation: shooting-star 12s linear infinite;
  top: 20%;
  left: 80%;
}

.shooting-stars::after {
  animation: shooting-star 10s linear infinite;
  animation-delay: 2.5s;
  top: 30%;
  left: 70%;
}

.shooting-star-extra {
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
  animation: shooting-star 10s linear infinite;
  animation-delay: 5s;
  top: 15%;
  left: 60%;
}

.shooting-star-extra2 {
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
  animation: shooting-star 12s linear infinite;
  animation-delay: 7.5s;
  top: 40%;
  left: 75%;
}

@keyframes stars-move {
  from {
    background-position: 0 0;
  }
  to {
    background-position: 250px 250px;
  }
}

@keyframes shooting-star {
  0% {
    transform: translateX(0) translateY(0) rotate(-45deg);
    opacity: 0;
  }
  2% {
    opacity: 1;
  }
  4% {
    transform: translateX(-100px) translateY(100px) rotate(-45deg);
    opacity: 0;
  }
  100% {
    transform: translateX(-100px) translateY(100px) rotate(-45deg);
    opacity: 0;
  }
}
</style>