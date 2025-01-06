<script setup>
import {inject, onMounted, ref} from 'vue'
import MovieActionsPanel from "@/vue/components/movies/show/MovieActionsPanel.vue"

const movieData = inject('movieData')
const movieId = inject('movieId')
const showActionsPanel = ref(false)

const formatDuration = (minutes) => {
  const hours = Math.floor(minutes / 60)
  const mins = String(minutes % 60).padStart(2, '0')
  return `${hours}h ${mins}m`
}

</script>

<template>
  <div class="flex flex-col justify-center items-start grow">
    <!-- Title Section -->
    <div>
      <h2 class="font-SourceProBold text-[1.7rem] md:text-[2.2rem] leading-10">
        <span>{{ movieData?.title }}</span>
        <span class="text-white/80 font-SourceProNormal">
          ({{ new Date(movieData?.release_date).getFullYear() }})
        </span>
      </h2>
      <div>
        <span class="text-white/90 text-[0.8rem] border border-white/70 inline-flex justify-center items-center sm:mr-[7px] ml-[1px] pb-[1px] px-1 rounded-sm leading-4">
          {{ movieData?.age_rating }}
        </span>
        <span>{{ new Date(movieData?.release_date).toLocaleDateString('en-GB') }} (GB)</span>
        <span class="disc relative ml-5"></span>
        <span>{{ movieData?.categories?.join(", ") }}</span>
        <span class="disc relative ml-5"></span>
        <span>{{ formatDuration(movieData?.duration) }}</span>
      </div>
    </div>

    <!-- Actions Panel Section -->
    <div
        v-show="!showActionsPanel"
        id="skeleton-actions-panel-loader"
        class="w-[410px] h-[68px] my-6 "
    >
      <div class="flex justify-between items-center space-x-2 p-2 ">
        <div class="w-16 h-16 bg-gray-200/20 rounded-full relative overflow-hidden">
          <div class="shimmer-wrapper"><div class="shimmer"></div></div>
        </div>
        <div>
          <div class="w-5 h-2 mb-2 bg-gray-200/20 rounded relative overflow-hidden">
            <div class="shimmer-wrapper"><div class="shimmer"></div></div>
          </div>
          <div class="w-7 h-2 bg-gray-200/20 rounded relative overflow-hidden">
            <div class="shimmer-wrapper"><div class="shimmer"></div></div>
          </div>
        </div>
        <div class="w-10 h-10 bg-gray-200/20 rounded-full relative overflow-hidden">
          <div class="shimmer-wrapper"><div class="shimmer"></div></div>
        </div>
        <div class="w-10 h-10 bg-gray-200/20 rounded-full relative overflow-hidden">
          <div class="shimmer-wrapper"><div class="shimmer"></div></div>
        </div>
        <div class="w-10 h-10 bg-gray-200/20 rounded-full relative overflow-hidden">
          <div class="shimmer-wrapper"><div class="shimmer"></div></div>
        </div>
        <div class="w-24 h-8 bg-gray-200/20 rounded relative overflow-hidden">
          <div class="shimmer-wrapper"><div class="shimmer"></div></div>
        </div>
      </div>
    </div>

    <div
        v-show="showActionsPanel"
        class="flex justify-center items-center gap-2 lg:gap-x-5 md:h-[68px] my-4 md:my-6"
    >
      <MovieActionsPanel
          v-if="movieId"
          @mounted="showActionsPanel = true"
      />
    </div>

    <!-- Movie Details Section -->
    <div>
      <p class="text-[1.1rem] italic text-white/70 leading-4 mt-2.5 md:mt-0">
        {{ movieData?.tagline }}
      </p>
      <div>
        <h3 class="text-[1.3rem] font-SourceProSemiBold mt-3 mb-1.5">Overview</h3>
        <p class="leading-6 text-justify lg:text-left">{{ movieData?.overview }}</p>
        <ul class="grid grid-cols-2 lg:grid-cols-3 xl:max-w-[90%] gap-y-5 font-SourceProBold mt-5">
          <!-- Crew list would go here -->
        </ul>
      </div>
    </div>
  </div>
</template>

<style scoped>
.disc::before {
  content: "•";
  position: absolute;
  top: 0;
  left: -15px;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
}

.shimmer-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  animation: loading 2.5s infinite;
}

.shimmer {
  width: 50%;
  height: 100%;
  background: rgba(255,255,255,0.2);
  transform: skewX(-20deg);
  box-shadow: 0 0 30px 30px rgba(255,255,255,0.05);
}

.shimmer-slow {
  animation: loading 2.5s infinite;
}

@keyframes loading {
  0% { transform: translateX(-150%); }
  50% { transform: translateX(-60%); }
  100% { transform: translateX(150%); }
}
</style>