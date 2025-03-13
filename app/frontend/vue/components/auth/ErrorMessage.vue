<template>
  <div v-if="Object.keys(errors).length > 0"
       class="text-sm bg-red-50 border border-red-200 rounded-lg p-3 sm:p-4 text-red-600">
    <ul class="list-disc list-inside">
      <li v-for="(error, key) in formattedErrors" :key="key">
        {{ error }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  errors: {
    type: Object,
    default: () => ({})
  }
})

const formattedErrors = computed(() => {
  return Object.entries(props.errors).reduce((acc, [field, message]) => {
    // Skip field name for authentication errors
    if (field === 'auth' || field === 'general') {
      acc[field] = message
    } else {
      const fieldName = field.charAt(0).toUpperCase() + field.slice(1).replace('_', ' ')
      acc[field] = `${fieldName} ${message}`
    }
    return acc
  }, {})
})
</script>