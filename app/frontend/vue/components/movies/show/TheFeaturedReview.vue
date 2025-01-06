<template>
  <div class="border border-tmdbLightGray p-5 rounded-lg shadow-light">
    <div class="flex justify-start items-center gap-4">
      <div class="w-[45px] h-[45px] rounded-full overflow-hidden">
        <img
            :src="review.user.avatar"
            :alt="review.user.username"
        >
      </div>
      <ReviewHeader :review="review" />
    </div>
    <ReviewContent :content="review.content" />
  </div>
</template>

<script setup>
import ReviewHeader from './ReviewHeader.vue'
import ReviewContent from './ReviewContent.vue'

defineProps({
  review: {
    type: Object,
    required: true,
    validator: (obj) => {
      return ['id', 'content', 'rating', 'created_at', 'user'].every(prop => prop in obj)
    }
  }
})
</script>