<template>
  <div class="filter-section">
    <div class="font-SourceProLight font-light pb-2.5">Sort Results By</div>
    <div class="relative font-SourceProNormal font-medium text-[0.9rem]">
      <select
          v-model="selectedSort"
          class="form-select"
          @change="$emit('update:modelValue', selectedSort)"
      >
        <option v-for="option in sortOptions" :key="option.value" :value="option.value">
          {{ option.label }}
        </option>
      </select>
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