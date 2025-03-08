<template>
  <nav v-if="totalPages > 1" class="flex justify-center items-center gap-2 mt-8" aria-label="Pagination">
    <button
        @click="onPageChange(currentPage - 1)"
        :disabled="currentPage === 1"
        class="relative inline-flex items-center px-3 py-2 rounded-md text-sm font-medium transition-colors"
        :class="[
        currentPage === 1
          ? 'text-gray-400 cursor-not-allowed'
          : 'text-gray-700 hover:bg-gray-100'
      ]"
    >
      <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
      </svg>
    </button>

    <div class="flex items-center gap-1">
      <template v-for="page in visiblePages" :key="page">
        <span v-if="page === '...'" class="px-3 py-2 text-gray-500">...</span>

        <button
            v-else
            @click="onPageChange(page)"
            class="relative inline-flex items-center px-3 py-2 rounded-md text-sm font-medium transition-all duration-200"
            :class="[
            page === currentPage
              ? 'bg-blue-500 text-white shadow-md transform scale-105'
              : 'text-gray-700 hover:bg-gray-100'
          ]"
        >
          {{ page }}
        </button>
      </template>
    </div>

    <button
        @click="onPageChange(currentPage + 1)"
        :disabled="currentPage === totalPages"
        class="relative inline-flex items-center px-3 py-2 rounded-md text-sm font-medium transition-colors"
        :class="[
        currentPage === totalPages
          ? 'text-gray-400 cursor-not-allowed'
          : 'text-gray-700 hover:bg-gray-100'
      ]"
    >
      <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
        <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
      </svg>
    </button>
  </nav>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  currentPage: {
    type: Number,
    required: true
  },
  totalPages: {
    type: Number,
    required: true
  }
})

const emit = defineEmits(['page-change'])

const visiblePages = computed(() => {
  const pages = []
  const totalPages = props.currentPage

  if (props.totalPages <= 7) {
    for (let i = 1; i <= props.totalPages; i++) {
      pages.push(i)
    }
  } else {
    pages.push(1)

    if (props.currentPage > 3) {
      pages.push('...')
    }

    for (let i = Math.max(2, props.currentPage - 1); i <= Math.min(props.totalPages - 1, props.currentPage + 1); i++) {
      pages.push(i)
    }

    if (props.currentPage < props.totalPages - 2) {
      pages.push('...')
    }

    pages.push(props.totalPages)
  }

  return pages
})

const onPageChange = (page) => {
  if (page >= 1 && page <= props.totalPages) {
    emit('page-change', page)
  }
}
</script>