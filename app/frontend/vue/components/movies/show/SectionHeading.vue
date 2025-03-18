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
  @apply relative z-10;
  background: linear-gradient(135deg, #0a4d7c, #0369a1);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-fill-color: transparent;
}

.title-decoration {
  @apply absolute -right-4 top-0 w-2 h-2 rounded-full;
  background: #0369a1;
  box-shadow: 0 0 10px rgba(3, 105, 161, 0.5);
  transform: scale(0);
  transition: transform 0.3s ease;
}

.section-title:hover .title-decoration {
  transform: scale(1);
}
</style>