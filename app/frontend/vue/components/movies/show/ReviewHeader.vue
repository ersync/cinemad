  <script setup>
  import { computed } from 'vue'
  import { useRoute } from 'vue-router'

  const route = useRoute()
  const movieSlug = route.params.slug

  const props = defineProps({
    review: {
      type: Object,
      required: true,
      validator: (obj) => {
        return obj && obj.user &&
            ['username'].every(prop => prop in obj.user) &&
            ['created_at'].every(prop => prop in obj);
      }
    }
  })


  </script>

<template>
    <div v-if="review?.user" class="flex flex-col gap-3">
      <!-- Meta Section -->
      <div class="flex items-center sm:gap-2">
        <span class="font-sourceLight text-[1rem] sm:text-[1.1rem] text-gray-400/95 dark:text-gray-500 uppercase">
          Featured Review
        </span>
  
        <div class="inline-flex items-center gap-1.5 bg-gray-900 dark:bg-gray-700 text-white px-3 py-1 rounded-lg font-medium scale-[0.64] sm:scale-[0.85]">
          <svg class="w-4 h-4 fill-yellow-400" viewBox="0 0 24 24">
            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
          </svg>
          <span>{{ (review.rating/20).toFixed(1) }}</span>
        </div>
      </div>
  
      <!-- Main Content -->
      <div class="flex flex-col gap-1">
        <h5 class="font-SourceProSemiBold text-xl sm:text-2xl leading-tight 
                  bg-gradient-to-r from-gray-800 to-blue-600 dark:from-gray-300 dark:to-blue-400 
                  bg-clip-text text-transparent">
          {{ review.user.username }}
        </h5>
  
        <p class="text-gray-600 dark:text-gray-400 text-[0.85rem] sm:text-[0.95rem] font-normal">
          Shared their thoughts {{ review.created_at }}
        </p>
      </div>
    </div>
  </template>