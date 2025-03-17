<script setup>
defineProps({
  title: {
    type: String,
    required: true
  }
})
</script>

<template>
  <header class="section-header">
    <h3 class="section-title">
      {{ title }}
      <span class="title-accent"></span>
    </h3>
  </header>
</template>

<style scoped>
.section-header {
  @apply relative;
}

.section-title {
  @apply relative inline-flex text-xl sm:text-2xl font-bold text-sky-900;
  padding-bottom: 0.5rem;
  letter-spacing: -0.01em;
}

/* The subtle accent line that appears under the text */
.title-accent {
  @apply absolute left-0 bottom-0 h-[2px] w-full;
  background: linear-gradient(to right, #0284c7, #0ea5e9, rgba(14, 165, 233, 0.1));
  transform-origin: left;
  transform: scaleX(0.4);
  transition: transform 0.3s ease-out;
}

/* Expand the line on hover */
.section-title:hover .title-accent {
  transform: scaleX(1);
}

/* Dark mode adjustments */
:global(.dark) .section-title {
  @apply text-sky-200;
}

:global(.dark) .title-accent {
  background: linear-gradient(to right, #38bdf8, #0ea5e9, rgba(14, 165, 233, 0.1));
}
</style>