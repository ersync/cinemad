<template>
  <div class="filter-section">
    <div class="relative">
      <select
        v-model="selectedSort"
        class="form-select appearance-none"
        @change="$emit('update:modelValue', selectedSort)"
      >
        <option 
          v-for="option in sortOptions" 
          :key="option.value" 
          :value="option.value"
        >
          {{ option.label }}
        </option>
      </select>
      <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-slate-500 dark:text-gray-400">
        <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selectedSort = ref(props.modelValue)

const sortOptions = [
  { value: 'popularity_desc', label: 'Popularity Descending' },
  { value: 'popularity_asc', label: 'Popularity Ascending' },
  { value: 'rating_desc', label: 'Rating Descending' },
  { value: 'rating_asc', label: 'Rating Ascending' },
  { value: 'release_date_desc', label: 'Release Date Descending' },
  { value: 'release_date_asc', label: 'Release Date Ascending' }
]
</script>