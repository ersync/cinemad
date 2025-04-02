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
      <span class="title-text">{{ title }}</span>
    </h3>
  </header>
</template>

<style scoped>
.section-header {
  @apply relative;
}

.section-title {
  @apply relative inline-flex text-xl sm:text-2xl font-bold;
  letter-spacing: -0.01em;
}

.title-text {
  @apply relative;
  background: linear-gradient(135deg, #3b82f6, #8b5cf6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-fill-color: transparent;
  text-shadow: 0 0 20px rgba(79, 70, 229, 0.3);
}

.title-decoration {
  @apply absolute -right-4 top-0 w-2 h-2 rounded-full;
  background: #8b5cf6;
  box-shadow: 0 0 15px rgba(139, 92, 246, 0.8);
}

:global(.dark) .title-text {
  background: linear-gradient(135deg, #8b5cf6, #c084fc);
  text-shadow: 0 0 20px rgba(139, 92, 246, 0.4);
}

:global(.dark) .title-decoration {
  background: #c084fc;
  box-shadow: 0 0 15px rgba(192, 132, 252, 0.8);
}
</style>