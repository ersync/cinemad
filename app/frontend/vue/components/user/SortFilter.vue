<template>
  <div class="flex items-center space-x-1 sm:space-x-3">
    <div class="relative" ref="filterRef">
      <button
          @click="isFilterOpen = !isFilterOpen"
          class="flex items-center px-1.5 py-[9px] sm:px-2 sm:py-2 sm:px-4 sm:py-2  bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors duration-200 focus:outline-none"
      >
        <svg class="w-4 h-4 sm:w-5 sm:h-5 text-gray-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
        </svg>
        <span class="text-[10px] sm:text-sm font-medium text-gray-700">{{ selectedFilter }}</span>
      </button>

      <div v-if="isFilterOpen"
           class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 z-50">
        <div class="py-1">
          <button v-for="option in filterOptions"
                  :key="option"
                  @click="selectFilter(option)"
                  class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 hover:text-tmdbLighterBlue transition-colors duration-200 flex items-center"
                  :class="{ 'text-tmdbLighterBlue bg-blue-50': selectedFilter === option }">
            <span :class="{ 'ml-6': selectedFilter !== option }">{{ option }}</span>
          </button>
        </div>
      </div>
    </div>

    <button @click="toggleOrder"
            class="flex items-center justify-center w-9 h-9 sm:w-10 sm:h-10 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors duration-200 focus:outline-none"
            :class="{ 'text-tmdbLighterBlue': isAscending }">
      <svg class="w-5 h-5 transition-transform duration-200"
           :class="{ 'rotate-180': !isAscending }"
           fill="none"
           stroke="currentColor"
           viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12" />
      </svg>
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { onClickOutside } from '@vueuse/core'

const props = defineProps({
  filterOptions: Array
})

const emit = defineEmits(['filter-change', 'order-change'])

const filterRef = ref(null)
const isFilterOpen = ref(false)
const selectedFilter = ref(props.filterOptions[0])
const isAscending = ref(true)

const selectFilter = (filter) => {
  selectedFilter.value = filter
  isFilterOpen.value = false
  emit('filter-change', filter)
}

const toggleOrder = () => {
  isAscending.value = !isAscending.value
  emit('order-change', isAscending.value ? 'asc' : 'desc')
}

onClickOutside(filterRef, () => {
  isFilterOpen.value = false
})
</script>