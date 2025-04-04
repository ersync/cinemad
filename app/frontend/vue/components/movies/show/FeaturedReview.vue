<script setup>
import { ref, onMounted } from 'vue'
import ReviewHeader from './ReviewHeader.vue'
import ReviewContent from './ReviewContent.vue'
import UserAvatar from '@/vue/components/user/UserAvatar.vue'

const props = defineProps({
  review: {
    type: Object,
    required: true,
    validator: (obj) => {
      return obj && ['id', 'content', 'rating', 'created_at', 'user'].every(prop => prop in obj)
    }
  }
})

const isVisible = ref(false)
onMounted(() => {
  setTimeout(() => {
    isVisible.value = true
  }, 100)
})
</script>

<template>
  <div
      :class="[
      'review-card relative overflow-hidden',
      'bg-white dark:bg-gray-800/90 backdrop-blur-md rounded-3xl',
      'shadow-lg hover:shadow-xl dark:shadow-gray-900/30 dark:hover:shadow-gray-900/50',
      'border border-slate-100/50 dark:border-gray-700/50',
      'transition-all duration-500 ease-out',
      isVisible ? 'opacity-100' : 'opacity-0'
    ]"
  >
    <div class="absolute -right-20 -top-20 w-40 h-40 
                bg-gradient-to-br from-indigo-100/30 to-purple-100/20 dark:from-indigo-900/20 dark:to-purple-900/10 
                rounded-full blur-xl"></div>
    <div class="absolute -left-10 -bottom-10 w-32 h-32 
                bg-gradient-to-tr from-amber-100/20 to-rose-100/10 dark:from-amber-900/10 dark:to-rose-900/5 
                rounded-full blur-xl"></div>

    <div class="relative z-10 p-6 sm:p-8">
      <div class="flex flex-col sm:flex-row sm:items-center gap-5">
        <div class="avatar-container relative shrink-0 group">
          <div
              class="w-16 h-16 rounded-full overflow-hidden
                  ring-2 ring-slate-100 dark:ring-gray-700 ring-offset-2
                  shadow-md transform group-hover:scale-105
                  transition-all duration-300"
          >
            <UserAvatar
                :image-url="review.user?.avatar_url"
                :username="review.user?.username"
                class="w-full h-full object-cover"
            />
          </div>
        </div>

        <div class="flex-1">
          <ReviewHeader
              :review="review"
              class="mb-1"
          />
        </div>
      </div>

      <div class="mt-5 sm:ml-[4.5rem]">
        <ReviewContent
            :content="review.content"
            class="text-slate-700 dark:text-gray-300 leading-relaxed"
        />
      </div>
    </div>
  </div>
</template>

<style scoped>
.review-card {
  background-image: linear-gradient(
    135deg, 
    rgba(255,255,255,0.4) 0%, 
    rgba(255,255,255,0.9) 50%, 
    rgba(255,255,255,0.4) 100%
  );
  box-shadow:
    0 3px 15px -3px rgba(0, 0, 0, 0.05),
    -1px -2px 6px -2px rgba(0, 0, 0, 0.03),
    0 0 0 1px rgba(255, 255, 255, 0.2) inset;
  
  /* Dark mode styles */
  @apply dark:bg-gradient-to-br dark:from-gray-900/30 dark:via-gray-800/90 dark:to-gray-900/30;
  @apply dark:shadow-[0_3px_15px_-3px_rgba(0,0,0,0.2),-1px_-2px_6px_-2px_rgba(0,0,0,0.1),0_0_0_1px_rgba(255,255,255,0.05)_inset];
}

.review-card:hover {
  box-shadow:
    0 15px 30px -5px rgba(0, 0, 0, 0.08),
    0 8px 10px -6px rgba(0, 0, 0, 0.03),
    0 0 0 1px rgba(255, 255, 255, 0.4) inset;
  
  /* Dark mode hover styles */
  @apply dark:shadow-[0_15px_30px_-5px_rgba(0,0,0,0.2),0_8px_10px_-6px_rgba(0,0,0,0.1),0_0_0_1px_rgba(255,255,255,0.1)_inset];
}

@media (prefers-reduced-motion: reduce) {
  .review-card {
    transition: none;
    transform: none;
  }
}
</style>