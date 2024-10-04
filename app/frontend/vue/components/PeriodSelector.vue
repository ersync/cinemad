<template>
  <div
      class="trending-selector flex font-SourceProSemiBold rounded-full border border-tmdbDarkBlue/80 max-w-min overflow-hidden text-tmdbDarkBlue select-none">
    <span
        v-for="period in periods"
        :key="period"
        :class="{ 'active_tab': selectedPeriod === formatPeriod(period) }"
        class="block py-0.5 px-3 rounded-full overflow-hidden transition-all duration-200 cursor-pointer"
        @click="$emit('periodSelected', formatPeriod(period))"
    >
      <a class="block w-full min-w-max">{{ period }}</a>
    </span>
  </div>
</template>

<script setup>
const props = defineProps({
  periods: Array,
  selectedPeriod: String,
})

const emit = defineEmits(['periodSelected'])

const formatPeriod = (period) => period.toLowerCase().replace(' ', '_')
</script>

<style scoped>
.active_tab {
  font-weight: bold;
  background-color: #032541;
  color: white;
}
</style>