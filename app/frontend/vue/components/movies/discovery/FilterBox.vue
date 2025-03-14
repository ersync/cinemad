<template>
  <div class="bg-white rounded-xl shadow-lg overflow-hidden mb-4 border border-slate-100 transition-all duration-300 hover:shadow-xl group">
    <div
      class="flex justify-between items-center p-4 cursor-pointer bg-gradient-to-r from-indigo-50 to-blue-50 group-hover:from-indigo-100 group-hover:to-blue-100 transition-colors duration-300"
      @click="toggleOpen"
    >
      <h3 class="text-lg font-medium text-slate-800">{{ title }}</h3>
      <div
        class="w-6 h-6 rounded-full bg-white flex items-center justify-center shadow-sm transition-transform duration-300"
        :class="{ 'rotate-180': isOpen }"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-600" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
      </div>
    </div>

    <div
      v-show="isOpen"
      class="p-4 transition-all duration-300"
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