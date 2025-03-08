<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight mb-2.5">Language</h2>
    <select
        v-model="selectedLanguage"
        class="form-select"
        @change="$emit('update:modelValue', selectedLanguage)"
    >
      <option value="">All Languages</option>
      <option
          v-for="lang in languageOptions"
          :key="lang.code"
          :value="lang.code"
      >
        {{ lang.name }}
      </option>
    </select>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selectedLanguage = ref(props.modelValue || '')

const languageOptions = [
  { code: 'en', name: 'English' },
  { code: 'es', name: 'Spanish' },
  { code: 'fr', name: 'French' },
  { code: 'de', name: 'German' },
  { code: 'it', name: 'Italian' },
  { code: 'ja', name: 'Japanese' },
  { code: 'ko', name: 'Korean' },
  { code: 'zh', name: 'Chinese' }
]
</script>