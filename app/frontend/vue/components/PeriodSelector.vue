<template>
  <div class="trending-selector flex font-SourceProSemiBold mt-0.5 rounded-full border border-tmdbDarkBlue/80
      min-w-min overflow-hidden text-tmdbDarkBlue select-none">
    <span
        v-for="period in periods"
        :key="period"
        :class="{ 'active_tab': selectedPeriod === formatPeriod(period) }"
        class="block py-0.5 sm:pb-1 px-2 sm:px-3 rounded-full overflow-hidden transition-all duration-300
              cursor-pointer text-[0.85rem] xs:text-base relative"
        @click="$emit('periodSelected', formatPeriod(period))"
    >
      <a class="block w-full min-w-max relative z-10">{{ period.replace(/ .*/, '') }}</a>
      <span class="absolute inset-0 bg-tmdbDarkBlue opacity-0 transition-all duration-500"></span>
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