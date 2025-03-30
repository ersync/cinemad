<template>
  <div class="filter-section">
    <h2>Show Me</h2>

    <div class="space-y-2">
      <label 
        v-for="option in options" 
        :key="option.value" 
        class="flex items-center p-2 rounded-md cursor-pointer transition-colors hover:bg-slate-50 dark:hover:bg-gray-700/50"
        :class="{ 'bg-slate-100 dark:bg-gray-700': selected === option.value }"
      >
        <div class="relative flex items-center justify-center">
          <input
            type="radio"
            v-model="selected"
            :value="option.value"
            class="sr-only"
          >
          <div class="w-5 h-5 border-2 rounded-full border-slate-300 dark:border-gray-600 group-hover:border-slate-400 dark:group-hover:border-gray-500 transition-colors duration-200">
          </div>
          <div 
            v-show="selected === option.value"
            class="absolute w-3 h-3 bg-gradient-to-r from-blue-800 to-navy-900 dark:from-indigo-500 dark:to-purple-600 rounded-full"
          ></div>
        </div>
        <span class="ml-2 text-sm text-slate-700 dark:text-gray-300">{{ option.label }}</span>
      </label>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selected = ref(props.modelValue || 'all')

const options = [
  { value: 'all', label: 'Everything' },
  { value: 'unwatched', label: 'Movies I Haven\'t Seen' },
  { value: 'watched', label: 'Movies I Have Seen' }
]

watch(selected, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>