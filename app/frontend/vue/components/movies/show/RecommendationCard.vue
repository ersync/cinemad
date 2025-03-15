<template>
  <li
      class="recommendation-card shrink-0 snap-start group relative"
      :style="{ width: '300px' }"
  >

    <a :href="`/movies/${movie.slug}`"
    class="block relative w-full h-full focus:outline-none focus-visible:ring-2 focus-visible:ring-indigo-500 focus-visible:ring-offset-2 rounded-xl"
    :aria-label="`View details for ${movie.title}`"
    >
    <div
        class="relative h-[380px] overflow-hidden rounded-xl
              transform-gpu transition-all duration-500 ease-out
              group-hover:scale-[1.03] group-hover:-translate-y-1
              group-hover:shadow-[0_20px_40px_rgba(0,0,0,0.18)]
              group-active:scale-[1.01] group-active:shadow-[0_10px_20px_rgba(0,0,0,0.16)]"
    >
      <div class="relative w-full h-full overflow-hidden">
        <!-- Main background image -->
        <div class="absolute inset-0 transform-gpu transition-all duration-700 ease-out
                      group-hover:scale-[1.1] group-hover:rotate-1">
          <img
              :src="movie.background_url"
              class="h-full w-full object-cover"
              :alt="`Background image for ${movie.title}`"
              loading="lazy"
              decoding="async"
          >
        </div>

        <div
            class="absolute inset-0 transition-opacity duration-500
                  bg-gradient-to-t from-black/75 via-black/50 to-black/20
                  group-hover:opacity-90"
        ></div>

        <div
            class="absolute inset-0 opacity-0 group-hover:opacity-20 transition-opacity duration-700
                  bg-gradient-to-br from-purple-300/30 via-transparent to-amber-200/30"
        ></div>
      </div>

      <!-- Content Container -->
      <div class="absolute inset-0 flex flex-col justify-between p-5">
        <!-- Top details -->
        <div class="flex justify-between items-start">
          <div
              v-if="movie.average_rating"
              class="relative flex items-center gap-1 px-3 py-1 rounded-full
                    backdrop-blur-lg bg-black/20 shadow-sm
                    bg-white/15 border border-white/20"
              :class="ratingTextClass"
              style="transform: none; transition: none;"
          >
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z" fill="currentColor"/>
            </svg>
            <span class="text-sm font-bold">{{ movie.average_rating }}%</span>
          </div>
        
        </div>

        <div
            class="transform transition-all duration-500 ease-out
                  group-hover:-translate-y-2"
        >
          
          <h4
              class="text-2xl font-bold text-white mb-2
                    transition-all duration-300 group-hover:scale-105 origin-left
                    drop-shadow-sm"
          >
            {{ movie.title }}
          </h4>

        </div>

        <div
            class="flex justify-center transform transition-all duration-500
                  translate-y-8 opacity-0 group-hover:translate-y-0 group-hover:opacity-100"
        >
            <span
                class="flex items-center gap-2 px-4 py-2 rounded-full
                    bg-white/20 backdrop-blur-lg hover:bg-white/30
                    border border-white/30 text-white text-sm font-medium
                    transition-all duration-300 shadow-lg"
            >
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M15 12L10 8V16L15 12Z" fill="currentColor"/>
                <circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="2" fill="none"/>
              </svg>
              View Details
            </span>
        </div>
      </div>

      <div class="absolute inset-0 rounded-xl ring-1 ring-white/10 pointer-events-none"></div>
    </div>
    </a>
  </li>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  movie: {
    type: Object,
    required: true,
    validator: (obj) => {
      return ['id', 'title', 'background_url', 'average_rating'].every(prop => prop in obj)
    }
  }
})

const ratingTextClass = computed(() => {
  const score = props.movie.average_rating
  if (score >= 80) return 'text-emerald-300'
  if (score >= 70) return 'text-green-300'
  if (score >= 60) return 'text-lime-300'
  if (score >= 50) return 'text-yellow-300'
  if (score >= 40) return 'text-amber-300'
  if (score >= 30) return 'text-orange-300'
  return 'text-red-300'
})

const formatRuntime = (minutes) => {
  if (!minutes) return ''
  const hours = Math.floor(minutes / 60)
  const mins = minutes % 60

  if (hours === 0) return `${mins}m`
  if (mins === 0) return `${hours}h`
  return `${hours}h ${mins}m`
}
</script>

<style scoped>
.recommendation-card {
  perspective: 1000px;
  transform-style: preserve-3d;
  overflow: hidden;
  border-radius: 0.75rem;
}

.recommendation-card::after {
  content: '';
  position: absolute;
  bottom: -20px;
  left: 5%;
  width: 90%;
  height: 20px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.2);
  filter: blur(10px);
  opacity: 0;
  transform: scaleX(0.95);
  transition: opacity 0.5s ease-out;
  z-index: -1;
}

.recommendation-card:hover::after {
  opacity: 0.6;
}

@media (prefers-color-scheme: dark) {
  .recommendation-card:hover::after {
    background: rgba(255, 255, 255, 0.05);
  }
}
</style>