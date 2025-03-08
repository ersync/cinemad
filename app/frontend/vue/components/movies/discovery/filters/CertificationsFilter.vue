<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight mb-2.5">Certifications</h2>
    <div class="flex flex-wrap gap-2 text-black">
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
        <span class="filter-tag peer-checked:bg-tmdbLighterBlue peer-checked:border-tmdbLighterBlue peer-checked:text-white transition-colors duration-200">
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

watch(selectedCertifications, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>