<template>
  <li class="recommendation-card shrink-0 snap-start group relative" :style="{ width: '300px' }">
    <a 
      :href="movie.id ? `/movies/${movie.id}` : '#'"
      class="block relative w-full h-full focus:outline-none focus-visible:ring-2 focus-visible:ring-indigo-500/70 focus-visible:ring-offset-2 rounded-xl"
      :aria-label="`View details for ${movie.title}`"
    >
      <div class="relative h-[380px] overflow-hidden rounded-xl
                  transform-gpu transition-all duration-500 ease-out
                  group-hover:scale-[1.03] group-hover:-translate-y-1
                  group-hover:shadow-[0_20px_40px_rgba(0,0,0,0.18)]
                  group-active:scale-[1.01]">
        
        <!-- Background Image -->
        <div class="absolute inset-0 transform-gpu transition-all duration-700 ease-out group-hover:scale-[1.08]">
          <img
            :src="movie.background_url"
            class="h-full w-full object-cover"
            :alt="`Background for ${movie.title}`"
            loading="lazy"
            decoding="async"
            @load="$emit('image-loaded')"
            @error="$emit('image-loaded')"
          >
        </div>

        <!-- Gradient Overlays -->
        <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent"></div>
        <div class="absolute inset-0 opacity-0 group-hover:opacity-30 transition-opacity duration-500
                  bg-gradient-to-tr from-purple-500/10 via-transparent to-amber-400/10"></div>

        <!-- Content -->
        <div class="absolute inset-0 flex flex-col justify-between p-5">
          <div v-if="movie.average_rating" class="flex justify-start">
            <div class="flex items-center gap-1 px-3 py-1 rounded-full backdrop-blur-md
                       bg-white/10 dark:bg-black/20 border border-white/20 dark:border-gray-700/50
                       shadow-[0_2px_10px_rgba(0,0,0,0.1)]"
                 :class="ratingTextClass">
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z"/>
              </svg>
              <span class="text-sm font-bold">{{ movie.average_rating }}%</span>
            </div>
          </div>

          <!-- Title -->
          <div class="transform transition-all duration-500 ease-out group-hover:-translate-y-2">
            <h4 class="text-2xl font-bold text-white mb-2 transition-all duration-300 
                       group-hover:scale-[1.02] origin-left drop-shadow-lg">
              {{ movie.title }}
            </h4>
          </div>

          <!-- CTA Button -->
          <div class="flex justify-center transform transition-all duration-500
                     translate-y-8 opacity-0 group-hover:translate-y-0 group-hover:opacity-100">
            <span class="flex items-center gap-2 px-4 py-2 rounded-full
                        bg-white/20 hover:bg-white/30 backdrop-blur-lg
                        border border-white/30 text-white text-sm font-medium
                        transition-all duration-300 shadow-lg hover:shadow-xl">
              <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none">
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
      return ['id', 'title', 'background_url'].every(prop => prop in obj)
    }
  }
})

defineEmits(['image-loaded'])

const ratingTextClass = computed(() => {
  const score = props.movie.average_rating
  if (!score) return ''
  if (score >= 80) return 'text-emerald-300'
  if (score >= 70) return 'text-green-300'
  if (score >= 60) return 'text-lime-300'
  if (score >= 50) return 'text-yellow-300'
  if (score >= 40) return 'text-amber-300'
  if (score >= 30) return 'text-orange-300'
  return 'text-red-300'
})
</script>

<style scoped>
.recommendation-card {
  perspective: 1000px;
}

.recommendation-card::before {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(45deg, transparent 40%, rgba(255,255,255,0.03) 100%);
  opacity: 0;
  transition: opacity 0.4s ease;
  z-index: 1;
  pointer-events: none;
}

.recommendation-card:hover::before {
  opacity: 1;
}
</style>