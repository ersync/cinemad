<template>
  <div class="shadow-sm py-2 my-8">
    <div class="flex flex-row justify-between items-center">
      <!-- Left Section -->
      <div class="flex items-center« space-x-2 sm:space-x-6">
        <div class="flex items-center space-x-2 sm:space-x-4">
          <h3 class="text-xl sm:text-2xl font-semibold text-gray-800">{{ title }}</h3>
          <div v-if="showCount"
               class="flex items-center justify-center px-2.5 py-1 sm:px-2.5 sm:py-1.5 text-sm sm:text-base bg-blue-100/80 rounded-full">
  <span class="text-sm sm:text-base font-medium text-tmdbLighterBlue">
    {{itemsCount}} <span class="hidden sm:inline">{{ itemsCount === 1 ? 'Movie' : 'Movies' }}</span>
  </span>
          </div>
        </div>
      </div>

      <!-- Right Section - View Toggle and Sort Filter -->
      <div class="flex items-center space-x-1 sm:space-x-4 self-center">
        <div class="flex items-center">
          <div class="flex items-center bg-gray-100 rounded-lg border border-gray-200">
            <button class="rounded-r-none p-[9px] rounded-lg hover:bg-white hover:shadow-sm transition-all duration-200"
                    :class="{ 'bg-white shadow-sm': viewMode === 'grid' }"
                    @click="setViewMode('grid')">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
              </svg>
            </button>
            <button class="rounded-l-none p-[9px] rounded-md hover:bg-white hover:shadow-sm transition-all duration-200"
                    :class="{ 'bg-white shadow-sm': viewMode === 'list' }"
                    @click="setViewMode('list')">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>

        <SortFilter
            :filter-options="filterOptions"
            @filter-change="handleFilterChange"
            @order-change="handleOrderChange"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import SortFilter from '@/vue/components/user/SortFilter.vue'

const props = defineProps({
  title: {
    type: String,
    required: true
  },
  showCount: {
    type: Boolean,
    default: false
  },
  itemsCount: {
    type: Number,
    default: 0
  },
  filterOptions: {
    type: Array,
    required: true
  }
})

const emit = defineEmits(['filter-change', 'order-change', 'view-mode-change'])

const viewMode = ref('list')

const handleFilterChange = (filter) => {
  emit('filter-change', filter)
}

const handleOrderChange = (order) => {
  emit('order-change', order)
}

const setViewMode = (mode) => {
  viewMode.value = mode
  emit('view-mode-change', mode)
}
</script>


<style>

</style>