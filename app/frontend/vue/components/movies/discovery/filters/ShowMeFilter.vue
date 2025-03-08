<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight">Show Me</h2>

    <label class="flex items-center">
      <input
          type="radio"
          v-model="selected"
          value="all"
          class="form-radio text-base"
      >
      <span class="ml-2">Everything</span>
    </label>

    <label class="flex items-center">
      <input
          type="radio"
          v-model="selected"
          value="unwatched"
          class="form-radio text-base"
      >
      <span class="ml-2">Movies I Haven't Seen</span>
    </label>

    <label class="flex items-center">
      <input
          type="radio"
          v-model="selected"
          value="watched"
          class="form-radio text-base"
      >
      <span class="ml-2">Movies I Have Seen</span>
    </label>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const selected = ref(props.modelValue || 'all')

watch(selected, (newValue) => {
  emit('update:modelValue', newValue)
})
</script>