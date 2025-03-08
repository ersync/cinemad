<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  counter: {
    type: [Number, String],
    default: null
  }
})
</script>

<template>
  <header class="section-header">
    <div class="flex items-center gap-x-3">
      <div class="relative">
        <h3 class="text-xl sm:text-2xl font-bold bg-gradient-text">
          {{ title }}
        </h3>
      </div>

      <span
          v-if="counter"
          class="counter-badge"
      >
        {{ counter }}
      </span>
    </div>
  </header>
</template>

<style scoped>
.section-header {
  @apply relative py-3;
}

.bg-gradient-text {
  @apply bg-clip-text text-transparent;
  background-image: linear-gradient(135deg, #034275, #0284c7, #0369a1);
  animation: shimmer 3s ease-in-out infinite;
}

.counter-badge {
  @apply text-[0.9rem] font-semibold;
  @apply w-7 h-7 sm:w-8 sm:h-8;
  @apply flex justify-center items-center rounded-full;
  @apply text-sky-700;
  @apply transition-all duration-300;
  background: linear-gradient(135deg, rgb(2 132 199 / 0.1), rgb(3 66 117 / 0.15));
  box-shadow: 0 2px 4px rgb(2 132 199 / 0.1);
  backdrop-filter: blur(8px);
}

.counter-badge:hover {
  @apply text-sky-800;
  background: linear-gradient(135deg, rgb(2 132 199 / 0.15), rgb(3 66 117 / 0.2));
  box-shadow: 0 4px 6px rgb(2 132 199 / 0.15);
  transform: translateY(-1px);
}

@keyframes shimmer {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

/* Dark mode adjustments */
:global(.dark) .counter-badge {
  @apply text-sky-300;
  background: linear-gradient(135deg, rgb(2 132 199 / 0.2), rgb(3 66 117 / 0.25));
}

:global(.dark) .counter-badge:hover {
  @apply text-sky-200;
  background: linear-gradient(135deg, rgb(2 132 199 / 0.25), rgb(3 66 117 / 0.3));
}

:global(.dark) .bg-gradient-text {
  background-image: linear-gradient(135deg, #60a5fa, #93c5fd, #60a5fa);
}
</style>