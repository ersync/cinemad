<template>
  <div class="filter-section">
    <h2>Certifications</h2>
    <div class="flex flex-wrap gap-2">
      <label
        v-for="cert in certificationOptions"
        :key="cert"
        class="relative inline-flex items-center cursor-pointer"
      >
        <input
          type="checkbox"
          :value="cert"
          v-model="selectedCertifications"
          class="peer sr-only"
        >
        <span 
          class="filter-tag peer-checked:bg-indigo-600 dark:peer-checked:bg-indigo-500 peer-checked:border-indigo-600 dark:peer-checked:border-indigo-500 peer-checked:text-white"
          :class="getCertClass(cert)"
        >
          {{ cert }}
        </span>
      </label>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selectedCertifications = ref(props.modelValue || [])

const certificationOptions = ['G', 'PG', 'PG-13', 'R', 'NC-17']

const getCertClass = (cert) => {
  switch(cert) {
    case 'G': return 'border-green-300 dark:border-green-700'
    case 'PG': return 'border-yellow-300 dark:border-yellow-700'
    case 'PG-13': return 'border-orange-300 dark:border-orange-700'
    case 'R': return 'border-red-300 dark:border-red-700'
    case 'NC-17': return 'border-red-500 dark:border-red-800'
    default: return ''
  }
}

watch(selectedCertifications, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>
