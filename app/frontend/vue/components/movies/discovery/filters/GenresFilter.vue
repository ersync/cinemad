<template>
  <div class="filter-section">
    <h2>Genres</h2>
    <div class="flex flex-wrap gap-2">
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
        <span class="filter-tag peer-checked:bg-indigo-600 peer-checked:border-indigo-600 peer-checked:text-white">
          {{ formatGenre(genre) }}
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

const formatGenre = (genre) => {
  return genre.split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ')
}

watch(selectedGenres, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>