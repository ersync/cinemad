<template>
  <div
      class="font-SourceProNormal scrollbar"
      :class="fadeClasses"
      ref="wrapperRef"
  >
    <ScrollableWrapper>
      <ul class="items-stretch flex gap-2 sm:gap-3.5">
        <CastCard
            v-for="person in cast"
            :key="person.id"
            :person="person"
            @image-loaded="$emit('image-loaded')"
        />
      </ul>
    </ScrollableWrapper>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import CastCard from '@/vue/components/movies/show/CastCard.vue'
import ScrollableWrapper from '@/vue/components/movies/shared/ScrollableWrapper.vue'

const props = defineProps({
  cast: {
    type: Array,
    required: true,
    default: () => [],
    validator: (value) => Array.isArray(value) && value.every(item =>
        typeof item === 'object' && 'id' in item
    )
  }
})

const emit = defineEmits(['image-loaded'])

const wrapperRef = ref(null)
const isVisible = ref(true)

const fadeClasses = computed(() => ({
  'fading': true,
  'fade_visible': isVisible.value,
  'fade_invisible': !isVisible.value
}))

const handleScroll = (element) => {
  isVisible.value = element.scrollLeft <= 45
}

const cleanup = () => {
  const scrollableElement = wrapperRef.value?.querySelector('.scrollable-wrapper')
  if (scrollableElement) {
    scrollableElement.removeEventListener('scroll', () => handleScroll(scrollableElement))
  }
}

onMounted(() => {
  const scrollableElement = wrapperRef.value?.querySelector('.scrollable-wrapper')
  if (scrollableElement) {
    scrollableElement.addEventListener('scroll', () => handleScroll(scrollableElement))
  }
})

onUnmounted(() => {
  cleanup()
})
</script>

<style scoped>
.fading {
  position: relative;
}

.fading::after {
  content: "";
  width: 40px;
  height: 100%;
  position: absolute;
  top: 0;
  right: 0;
  background-image: linear-gradient(to right, rgba(246, 248, 252, 0) 0, #f6f8fc 100%);
  @apply dark:bg-gradient-to-r dark:from-transparent dark:to-gray-900;
  will-change: opacity;
  pointer-events: none;
  transition: opacity linear 0.3s;
}

.fade_visible::after {
  opacity: 1;
}

.fade_invisible::after {
  opacity: 0;
}

.scrollbar::-webkit-scrollbar {
  @apply h-1.5;
}

.scrollbar::-webkit-scrollbar-track {
  @apply bg-gray-100 dark:bg-gray-800;
}

.scrollbar::-webkit-scrollbar-thumb {
  @apply bg-gray-300 dark:bg-gray-600 rounded-full;
}

.scrollbar::-webkit-scrollbar-thumb:hover {
  @apply bg-gray-400 dark:bg-gray-500;
}
</style>