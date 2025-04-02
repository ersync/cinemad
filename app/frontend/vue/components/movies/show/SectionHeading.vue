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
      <span class="title-decoration"></span>
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


</style>