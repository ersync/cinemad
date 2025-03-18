<template>
  <div v-if="content" class="leading-relaxed text-[#2c3e50]">
    <p class="mb-4 text-[0.9rem] sm:text-[1.05rem] tracking-[0.01em] font-normal">
      {{ content }}
    </p>
    <a
        href="#"
        class="inline-block font-medium relative py-1 transition-all duration-300 bg-gradient-to-r from-[#0a4d7c] to-[#0369a1] bg-clip-text text-transparent hover:from-[#0369a1] hover:to-[#0a4d7c] after:content-[''] after:absolute after:bottom-0 after:left-1/2 after:-translate-x-1/2 after:w-1/3 after:h-[1px] after:bg-gradient-to-r after:from-transparent after:via-[#0369a1] after:to-transparent hover:after:w-full after:transition-all after:duration-300"
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