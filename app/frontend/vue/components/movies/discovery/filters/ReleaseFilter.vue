<template>
  <div class="filter-section">
    <h2>Release</h2>

    <div class="space-y-2 mb-4">
      <div 
        v-for="option in releaseFormatOptions" 
        :key="option.value" 
        class="flex items-center"
      >
        <label class="flex items-center cursor-pointer">
          <div class="relative flex items-center justify-center">
            <input
              type="checkbox"
              :value="option.value"
              v-model="selectedFormats"
              class="sr-only"
            >
            <div class="w-5 h-5 border-2 rounded-md border-slate-300 transition-all duration-200"
                :class="{'border-[#112240] bg-[#112240]': selectedFormats.includes(option.value)}"
            ></div>
            <div 
              v-show="selectedFormats.includes(option.value)"
              class="absolute w-1.5 h-1.5 bg-white rounded-full"
            ></div>
          </div>
          <span class="ml-2 text-sm text-slate-700">{{ option.label }}</span>
        </label>
      </div>
    </div>

    <div class="space-y-3">
      <div class="grid grid-cols-3 items-center gap-2">
        <label class="text-xs font-medium text-slate-500">From</label>
        <div class="col-span-2">
          <input
            type="date"
            v-model="dates.from"
            class="block w-full rounded-md border-slate-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 text-xs py-1.5 px-2.5"
          >
        </div>
      </div>

      <div class="grid grid-cols-3 items-center gap-2">
        <label class="text-xs font-medium text-slate-500">To</label>
        <div class="col-span-2">
          <input
            type="date"
            v-model="dates.to"
            class="block w-full rounded-md border-slate-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 text-xs py-1.5 px-2.5"
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
  dateTo: String,
  all: {
    type: String,
    default: '0'
  }
})

const emit = defineEmits(['update:formats', 'update:dateFrom', 'update:dateTo', 'update:all'])

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
  emit('update:all', newValue.length === 0 ? '1' : '0')
})

watch(() => dates.value.from, (newValue) => {
  emit('update:dateFrom', newValue)
})

watch(() => dates.value.to, (newValue) => {
  emit('update:dateTo', newValue)
})
</script>