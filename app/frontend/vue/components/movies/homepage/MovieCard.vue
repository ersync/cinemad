<template>
  <div class="w-[130px] sm:w-[150px] shrink-0">
    <div class="relative">
      <div class="overflow-hidden rounded-lg min-h-[195px] sm:min-h-[225px] aspect-[2/3] bg-gray-100 dark:bg-gray-800">
        <a :href="moviePath">
          <img
              :src="movie.cover_url"
              :alt="movie.title"
              class="w-full h-full object-cover"
              @load="$emit('image-loaded')"
              @error="$emit('image-loaded')"
          />
        </a>
      </div>
      <AvgRateBadge
          :average-rating="movie.average_rating"
          class="absolute -bottom-5 left-3"
          :should-animate="false"
      />
    </div>
    <div class="pl-2 mt-6 sm:pl-2.5">
      <h3 class="font-SourceProBold text-sm sm:text-base leading-4 line-clamp-2 text-gray-900 dark:text-gray-100">
        <a :href="moviePath" class="line-clamp-1">{{ movie.title }}</a>
      </h3>
      <span class="text-gray-600/80 dark:text-gray-400/90 text-[0.7rem] sm:text-[0.9rem]">{{ formattedDate }}</span>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import AvgRateBadge from "@/vue/components/movies/shared/AvgRateBadge.vue"

const props = defineProps({
  movie: {
    type: Object,
    required: true,
    validator: function(value) {
      return value.id && value.title && value.cover_url
    }
  }
})

defineEmits(['image-loaded'])

const moviePath = computed(() => {
  return `/movies/${props.movie.slug}`
})

const formattedDate = computed(() => {
  if (!props.movie.release_date) return ''
  const date = new Date(props.movie.release_date)
  return date.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric'
  })
})
</script>