<script setup>
import { ref, onMounted } from 'vue'
import ScrollBooster from 'scrollbooster'

const wrapperRef = ref(null)
const emit = defineEmits(['drag-state'])

const isTouchDevice = () => {
  return 'ontouchstart' in window ||
      navigator.maxTouchPoints > 0 ||
      navigator.msMaxTouchPoints > 0
}

const handleFading = (wrapper) => {
  const leftHorizontalOffset = wrapper.scrollLeft
  if (leftHorizontalOffset > 45) {
    wrapper.classList.add('fade_invisible')
    wrapper.classList.remove('fade_visible')
  } else {
    wrapper.classList.add('fade_visible')
    wrapper.classList.remove('fade_invisible')
  }
}

onMounted(() => {
  const wrapper = wrapperRef.value
  const content = wrapper.querySelector('.scrollable-content')

  if (!isTouchDevice()) {
    new ScrollBooster({
      viewport: wrapper,
      content: content,
      scrollMode: 'native',
      direction: 'horizontal',
      onDrag: ({ isDragging }) => {
        emit('drag-state', isDragging)
      }
    })
  } else {
    wrapper.style.overflowX = 'auto'
    wrapper.style.WebkitOverflowScrolling = 'touch'
  }

  wrapper.addEventListener('scroll', () => handleFading(wrapper))
})
</script>

<template>
  <div class="scrollable-wrapper" ref="wrapperRef">
    <div class="scrollable-content">
      <slot></slot>
    </div>
  </div>
</template>

<style scoped>
.scrollable-wrapper {
  @apply relative overflow-x-auto pb-4;
  -webkit-overflow-scrolling: touch;
}

.scrollable-wrapper::-webkit-scrollbar {
  height: 6px;
}

.scrollable-wrapper::-webkit-scrollbar-thumb {
  @apply bg-gray-300 dark:bg-gray-600 rounded-full hover:bg-gray-400 dark:hover:bg-gray-500 transition-colors;
}

.scrollable-content {
  @apply relative;
}
</style>