<template>
  <div class="trending-selector flex font-SourceProSemiBold rounded-full border border-tmdbDarkBlue/80 max-w-min overflow-hidden text-tmdbDarkBlue">
    <button
        v-for="(period, index) in periods"
        :key="period"
        :class="[
        'block py-0.5 px-5 rounded-full overflow-hidden transition-all duration-200',
        { 'active_tab': isSelected(period) }
      ]"
        @click="$emit('period-selected', periodToValue(period))"
    >
      <span class="block w-full min-w-max">{{ period }}</span>
    </button>
  </div>
</template>

<script setup>
const props = defineProps({
  periods: {
    type: Array,
    required: true
  },
  selectedPeriod: {
    type: String,
    required: true
  }
})

defineEmits(['period-selected'])

const periodToValue = (period) => {
  return period.toLowerCase().replace(' ', '_')
}

const isSelected = (period) => {
  return periodToValue(period) === props.selectedPeriod
}
</script>

<style scoped>
.active_tab {
  @apply bg-tmdbDarkBlue text-white;
}

.trending-selector button:hover:not(.active_tab) {
  @apply bg-tmdbDarkBlue/10;
}
</style>