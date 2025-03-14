<script setup>
import { ref, computed } from 'vue'
import { useMovieStore } from "@/vue/stores/movieStore"
import MovieActionsPanelDesktop from "@/vue/components/movies/show/MovieActionsPanelDesktop.vue"
import CrewMemberDesktop from "@/vue/components/movies/show/CrewMemberDesktop.vue"
import { useRoute } from "vue-router"

const route = useRoute()
const slug = route.params.slug

const movieStore = useMovieStore()
const { data: movieData } = movieStore.movieComputed(slug)
const showActionsPanel = ref(false)

const formatDuration = (minutes) => {
  if (!minutes) return '0h 00m'
  const hours = Math.floor(minutes / 60)
  const mins = String(minutes % 60).padStart(2, '0')
  return `${hours}h ${mins}m`
}

const uniqueCrewMembers = computed(() => {
  if (!movieData.value?.crew) return []

  return movieData.value.crew
})

const formattedReleaseDate = computed(() => {
  if (!movieData.value?.release_date) return ''
  try {
    return new Date(movieData.value.release_date).toLocaleDateString('en-GB')
  } catch (e) {
    return ''
  }
})

const releaseYear = computed(() => {
  if (!movieData.value?.release_date) return ''
  try {
    return new Date(movieData.value.release_date).getFullYear()
  } catch (e) {
    return ''
  }
})
</script>

<template>
  <div class="flex flex-col justify-center items-start grow">
    <div class="movie-header space-y-3 py-3">
      <h2 class="flex flex-wrap items-baseline gap-x-4">
        <span class="text-3xl md:text-5xl font-SourceProBold bg-gradient-to-r from-white to-white/90 bg-clip-text text-transparent">
          {{ movieData?.title }}
        </span>
        <span class="text-2xl md:text-3xl font-SourceProNormal text-white/60">
          {{ releaseYear }}
        </span>
      </h2>

      <div class="flex flex-wrap items-center gap-4 text-sm">
        <div class="flex items-center flex-wrap gap-x-2 gap-y-2">
          <div class="flex items-center gap-x-2">
            <span class="px-2 py-1 bg-white/10 backdrop-blur-sm rounded-lg font-medium
                     border border-white/5 shadow-lg shadow-black/10
                     hover:bg-white/15 transition-all duration-300">
              {{ movieData?.age_rating }}
            </span>
            <span class="text-white/80">
              {{ formattedReleaseDate }}
              <span class="text-emerald-400 ml-1">GB</span>
            </span>
          </div>

          <span class="h-4 w-[1px] bg-white/40 hidden lg:block"></span>

          <div class="flex items-center gap-x-2">
            <span class="text-white/80 hover:text-white transition-colors duration-300">
              {{ movieData?.categories?.join(" • ") }}
            </span>
            <span class="h-4 w-[1px] bg-white/40"></span>
            <span class="flex items-center gap-2 text-white/80">
              <svg class="w-4 h-4 text-white/40" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                <circle cx="12" cy="12" r="10" stroke-width="2" />
                <path d="M12 6v6l4 2" stroke-width="2" stroke-linecap="round" />
              </svg>
              {{ formatDuration(movieData?.duration) }}
            </span>
          </div>
        </div>
      </div>
    </div>

    <div
        v-show="!showActionsPanel"
        id="skeleton-actions-panel-loader"
        class="w-[410px] h-[68px] my-6"
    >
      <div class="flex justify-between items-center space-x-2 p-2">
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
        class="flex justify-center items-center gap-2 lg:gap-x-5 md:h-[68px] my-4"
    >
      <MovieActionsPanelDesktop
          :movie-slug="slug"
          @panel-mounted="showActionsPanel = true"
      />
    </div>

    <div>
      <p class="text-[1.1rem] italic text-white/70 leading-4 mt-3 md:mt-0">
        {{ movieData?.tagline }}
      </p>
      <div>
        <h3 class="text-[1.3rem] font-SourceProSemiBold mt-3 mb-1.5">Overview</h3>
        <p class="leading-6 text-justify lg:text-left">{{ movieData?.overview }}</p>
        <ul class="grid grid-cols-2 lg:grid-cols-3 xl:max-w-[90%] gap-y-5 font-SourceProBold mt-5">
          <CrewMemberDesktop
              v-for="crewMember in uniqueCrewMembers"
              :key="crewMember.id"
              :crew="crewMember"
          />
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