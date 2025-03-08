<template>
  <div class="inline-flex p-0.5 bg-white/5 backdrop-blur-sm rounded-full">
    <button
        v-for="option in options"
        :key="getOptionValue(option)"
        :class="[
          'relative px-1.5 py-1 sm:px-3.5 sm:py-1.5 text-xs sm:text-sm font-medium rounded-md transition-all duration-200 antialiased',
          'hover:bg-black/[0.02]',
          isSelected(option)
            ? 'text-black bg-white shadow-sm font-SourceProSemiBold'
            : 'text-gray-500'
        ]"
        @click="$emit('tab-selected', getOptionValue(option))"
    >
      <span class="relative z-10">{{ getOptionLabel(option) }}</span>

      <div
          v-if="isSelected(option)"
          class="absolute inset-0 rounded-md bg-gray-100/80"
          aria-hidden="true"
      ></div>
    </button>
  </div>
</template>

<script setup>
const props = defineProps({
  options: {
    type: Array,
    required: true
  },
  selectedValue: {
    type: String,
    required: true
  }
})

defineEmits(['tab-selected'])

const getOptionValue = (option) => {
  return typeof option === 'object' ? option.value : option.toLowerCase().replace(/\s+/g, '_')
}

const getOptionLabel = (option) => {
  return typeof option === 'object' ? option.label : option
}

const isSelected = (option) => {
  return getOptionValue(option) === props.selectedValue
}
</script>