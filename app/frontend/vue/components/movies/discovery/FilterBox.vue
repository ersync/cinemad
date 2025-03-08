<template>
  <div class="border border-gray-300 rounded-lg p-4 mb-4">
    <div
        class="flex justify-between items-center cursor-pointer"
        @click="toggleOpen"
    >
      <h3 class="text-lg font-semibold">{{ title }}</h3>
      <span
          class="chevron"
          :class="{ 'rotate': isOpen }"
      ></span>
    </div>

    <div
        v-show="isOpen"
        class="mt-3"
    >
      <slot></slot>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

defineProps({
  title: {
    type: String,
    required: true
  }
})

const isOpen = ref(false)
const previousWidth = ref(window.innerWidth)
const userToggled = ref(false)

const checkScreenSize = () => {
  const currentWidth = window.innerWidth
  if (currentWidth !== previousWidth.value && !userToggled.value) {
    isOpen.value = currentWidth >= 640
    previousWidth.value = currentWidth
  }
}

const toggleOpen = () => {
  userToggled.value = true
  isOpen.value = !isOpen.value
}

onMounted(() => {
  checkScreenSize()
  window.addEventListener('resize', checkScreenSize)
})

onUnmounted(() => {
  window.removeEventListener('resize', checkScreenSize)
})
</script>


<style scoped>
.chevron {
  border-right: 2px solid #666;
  border-bottom: 2px solid #666;
  width: 8px;
  height: 8px;
  transform: rotate(45deg);
  transition: transform 0.3s ease;
}

.chevron.rotate {
  transform: rotate(-135deg);
}
</style>