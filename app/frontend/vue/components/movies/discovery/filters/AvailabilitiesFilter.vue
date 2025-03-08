<template>
  <div class="filter-section">
    <h2 class="font-SourceProLight">Availabilities</h2>
    <div class="flex flex-wrap gap-2 text-black">
      <label
          v-for="option in availabilityOptions"
          :key="option"
          class="relative inline-flex items-center cursor-pointer"
      >
        <input
            type="checkbox"
            :value="option"
            v-model="selectedAvailabilities"
            @change="handleAvailabilityChange"
            class="peer sr-only"
        >
        <span class="filter-tag peer-checked:bg-tmdbLighterBlue peer-checked:border-tmdbLighterBlue peer-checked:text-white transition-colors duration-200">
          {{ option }}
        </span>
      </label>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

const props = defineProps({
  availabilities: {
    type: Object,
    default: () => ({})
  },
  all: {
    type: String,
    default: '0'
  }
})

const emit = defineEmits(['update:availabilities', 'update:all'])

const selectedAvailabilities = ref([])

const availabilityOptions = [
  'Stream', 'Free', 'Ads', 'Rent', 'Buy'
]

const handleAvailabilityChange = () => {
  const availabilitiesObj = {}
  selectedAvailabilities.value.forEach(option => {
    availabilitiesObj[option.toLowerCase()] = true
  })
  emit('update:availabilities', availabilitiesObj)

  // Update the all_availabilities value
  emit('update:all', selectedAvailabilities.value.length === 0 ? '1' : '0')
}

// Initialize selected availabilities from props if needed
watch(() => props.availabilities, (newValue) => {
  selectedAvailabilities.value = Object.entries(newValue)
      .filter(([_, value]) => value)
      .map(([key, _]) => key.charAt(0).toUpperCase() + key.slice(1))
}, { immediate: true })
</script>