<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight">Release</h2>

    <div v-for="option in releaseFormatOptions" :key="option.value" class="flex items-center">
      <label class="flex items-center">
        <input
            type="checkbox"
            :value="option.value"
            v-model="selectedFormats"
            class="form-checkbox"
        >
        <span class="ml-2">{{ option.label }}</span>
      </label>
    </div>

    <div class="flex flex-col space-y-1 mt-2">
      <div class="flex justify-between items-center">
        <label class="block text-[0.9rem] font-medium text-gray-400 pt-1">from</label>
        <div class="mt-1 relative w-[70%]">
          <input
              type="date"
              v-model="dates.from"
              class="block w-full border border-gray-300 rounded-md text-xs text-gray-500 focus:ring-indigo-500 focus:border-indigo-500 py-1.5 px-3"
          >
        </div>
      </div>

      <div class="flex justify-between items-center">
        <label class="block text-[0.9rem] font-medium text-gray-400 pt-1">to</label>
        <div class="mt-1 relative w-[70%]">
          <input
              type="date"
              v-model="dates.to"
              class="block w-full border border-gray-300 rounded-md text-xs text-gray-500 focus:ring-indigo-500 focus:border-indigo-500 py-1.5 px-3"
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  formats: Array,
  dateFrom: String,
  dateTo: String
})

const emit = defineEmits(['update:formats', 'update:dateFrom', 'update:dateTo'])

const selectedFormats = ref(props.formats || [])
const dates = ref({
  from: props.dateFrom || null,
  to: props.dateTo || new Date().toISOString().split('T')[0]
})

const releaseFormatOptions = [
  { value: 'theatrical', label: 'Theatrical' },
  { value: 'digital', label: 'Digital' },
  { value: 'physical', label: 'Physical' },
  { value: 'premiere', label: 'Premiere' },
  { value: 'tv', label: 'TV' }
]

watch(selectedFormats, (newValue) => {
  emit('update:formats', newValue)
})

watch(() => dates.value.from, (newValue) => {
  emit('update:dateFrom', newValue)
})

watch(() => dates.value.to, (newValue) => {
  emit('update:dateTo', newValue)
})
</script>