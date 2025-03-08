<template>
  <div class="loader-wrapper" :class="{ 'is-loading': isLoading }">
    <div class="loader">
      <svg viewBox="0 0 24 24" class="spinner">
        <circle class="spinner-track" cx="12" cy="12" r="10" />
        <circle class="spinner-active" cx="12" cy="12" r="10" />
      </svg>
    </div>
  </div>
</template>

<script setup>
defineProps({
  isLoading: {
    type: Boolean,
    default: true
  }
})
</script>

<style scoped>
.loader-wrapper {
  position: fixed;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  z-index: 50;
  pointer-events: none;
}

.loader {
  width: 40px;
  height: 40px;
  position: relative;
  opacity: 0;
  transform: scale(0.8);
  transition: all 0.2s ease;
}

.loader-wrapper.is-loading .loader {
  opacity: 1;
  transform: scale(1);
}

.spinner {
  width: 100%;
  height: 100%;
  animation: rotate 1.4s linear infinite;
}

.spinner-track {
  fill: none;
  stroke: rgba(0, 0, 0, 0.1);
  stroke-width: 2.5;
}

.spinner-active {
  fill: none;
  stroke: #2563eb;
  stroke-width: 2.5;
  stroke-dasharray: 63;
  stroke-dashoffset: 63;
  stroke-linecap: round;
  animation: dash 1.4s ease-in-out infinite;
}

@keyframes rotate {
  100% {
    transform: rotate(360deg);
  }
}

@keyframes dash {
  0% {
    stroke-dashoffset: 63;
  }
  50% {
    stroke-dashoffset: 32;
  }
  100% {
    stroke-dashoffset: 63;
  }
}

@media (prefers-color-scheme: dark) {
  .spinner-track {
    stroke: rgba(255, 255, 255, 0.1);
  }
  .spinner-active {
    stroke: #60a5fa;
  }
}
</style>