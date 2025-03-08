<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight mb-2.5">Genres</h2>
    <div class="flex flex-wrap gap-2 text-black">
      <label
          v-for="genre in genreOptions"
          :key="genre"
          class="relative inline-flex items-center cursor-pointer"
      >
        <input
            type="checkbox"
            :value="genre"
            v-model="selectedGenres"
            class="peer sr-only"
        >
        <span class="filter-tag peer-checked:bg-tmdbLighterBlue peer-checked:border-tmdbLighterBlue peer-checked:text-white transition-colors duration-200">
          {{ genre }}
        </span>
      </label>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selectedGenres = ref(props.modelValue || [])

const genreOptions = ['action', 'adventure', 'animation', 'comedy', 'crime', 'documentary', 'drama', 'family', 'fantasy',
  'history', 'horror', 'music', 'mystery', 'romance', 'science fiction', 'TV movie', 'thriller', 'war', 'western']

watch(selectedGenres, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>