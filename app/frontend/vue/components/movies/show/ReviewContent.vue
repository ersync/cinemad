<template>
  <div v-if="content" class="leading-relaxed text-[#2c3e50]">
    <p class="mb-4 text-[0.9rem] sm:text-[1.05rem] tracking-[0.01em] font-normal">
      {{ content }}
    </p>
    <a
        href="#"
        class="inline-block text-[#3498db] font-medium no-underline relative py-1 transition-colors duration-200 hover:text-[#2980b9] after:content-[''] after:absolute after:bottom-[-2px] after:left-0 after:w-full after:h-0.5 after:bg-gradient-to-r after:from-[#3498db] after:to-[#2980b9] after:scale-x-0 after:origin-left after:transition-transform after:duration-300 after:ease-out hover:after:scale-x-100"
        @click.prevent="openReviewsPopup()"
    >
      Read the rest
    </a>
  </div>
</template>

<script setup>
  import { inject } from 'vue'


defineProps({
  content: {
    type: String,
    required: true,
    validator: (value) => {
      return value && value.trim().length > 0
    }
  }
})

const openReviewsPopup = inject('openReviewsPopup')


</script>

<style scoped>
</style>