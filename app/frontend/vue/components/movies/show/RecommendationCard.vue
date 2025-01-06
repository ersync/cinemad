<template>
  <li class="shrink-0 snap-start">
    <a
        :href="`/movies/${movie.id}`"
        class="block"
        :aria-label="`View details for ${movie.title}`"
    >
      <div class="w-[250px] h-[141px] overflow-hidden rounded-lg">
        <div class="block w-full h-full">
          <img
              :src="movie.background_url"
              class="h-full object-cover"
              alt=""
              loading="lazy"
              decoding="async"
          >
        </div>
      </div>
      <div class="flex justify-between items-center mt-1">
        <span class="inline-block text-black/80">{{ movie.title }}</span>
        <span
            class="inline-block"
            :class="scoreColorClass"
            aria-label="Match score"
        >
          {{ movie.average_rating }}%
        </span>
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

const scoreColorClass = computed(() => {
  const score = props.movie.average_rating
  if (score >= 70) return 'text-green-600'
  if (score >= 40) return 'text-yellow-600'
  return 'text-red-600'
})
</script>