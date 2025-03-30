<template>
  <div class="pagination">
    <!-- Previous button -->
    <button
      class="pagination-btn"
      :disabled="currentPage === 1"
      @click="changePage(currentPage - 1)"
      aria-label="Previous page"
    >
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M15 19L8 12L15 5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </button>
    
    <!-- Page numbers -->
    <div class="page-numbers">
      <template v-for="page in displayedPages" :key="page">
        <button
          v-if="page !== '...'"
          class="page-number"
          :class="{ active: page === currentPage }"
          @click="changePage(page)"
        >
          {{ page }}
        </button>
        <span v-else class="ellipsis">•••</span>
      </template>
    </div>
    
    <!-- Next button -->
    <button
      class="pagination-btn"
      :disabled="currentPage === totalPages"
      @click="changePage(currentPage + 1)"
      aria-label="Next page"
    >
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M9 5L16 12L9 19" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </button>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  currentPage: {
    type: Number,
    required: true
  },
  totalPages: {
    type: Number,
    required: true
  }
});

const emit = defineEmits(['page-change']);

const displayedPages = computed(() => {
  if (props.totalPages <= 7) {
    return Array.from({ length: props.totalPages }, (_, i) => i + 1);
  }
  
  if (props.currentPage <= 4) {
    return [1, 2, 3, 4, 5, '...', props.totalPages];
  }
  
  if (props.currentPage >= props.totalPages - 3) {
    return [1, '...', props.totalPages - 4, props.totalPages - 3,
      props.totalPages - 2, props.totalPages - 1, props.totalPages];
  }
  
  return [
    1, '...',
    props.currentPage - 1, props.currentPage, props.currentPage + 1,
    '...', props.totalPages
  ];
});

const changePage = (page) => {
  if (page !== props.currentPage && page >= 1 && page <= props.totalPages) {
    emit('page-change', page);
  }
};
</script>

<style scoped>
.pagination {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 2rem 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
  user-select: none;
}

.pagination-btn, .page-number {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 38px;
  background: transparent;
  border: none;
  color: #484848;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.pagination-btn {
  width: 38px;
  padding: 0;
  color: #686868;
}

.page-number {
  min-width: 38px;
  margin: 0 2px;
  border-radius: 6px;
}

.pagination-btn:hover:not(:disabled), .page-number:hover:not(.active) {
  color: #111;
  background: rgba(0, 0, 0, 0.04);
}

.pagination-btn:disabled {
  cursor: not-allowed;
  opacity: 0.3;
}

.page-number.active {
  background: rgba(66, 153, 225, 0.06);
  color: #2b6cb0;
  font-weight: 600;
  border: 1px solid rgba(116, 153, 225, 0.25);
}

.page-numbers {
  display: flex;
  align-items: center;
  margin: 0 8px;
}

.ellipsis {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 38px;
  min-width: 24px;
  color: #a0a0a0;
  font-size: 10px;
  letter-spacing: 1px;
  margin: 0 2px;
}

@media (hover: hover) {
  .page-number.active:hover {
    background: rgba(66, 153, 225, 0.18);
  }
  
  .pagination-btn:active, .page-number:active {
    transform: scale(0.95);
  }
}

@media (max-width: 480px) {
  .pagination {
    font-size: 13px;
  }
  
  .pagination-btn, .page-number {
    height: 34px;
  }
  
  .pagination-btn {
    width: 34px;
  }
  
  .page-number {
    min-width: 34px;
  }
}

@media (prefers-color-scheme: dark) {
  .pagination-btn, .page-number {
    color: #d1d1d1;
  }
  
  .pagination-btn:hover:not(:disabled), .page-number:hover:not(.active) {
    color: #ffffff;
    background: rgba(255, 255, 255, 0.1);
  }
  
  .page-number.active {
    background: rgba(66, 153, 225, 0.2);
    color: #63b3ed;
    border: 1px solid rgba(116, 153, 225, 0.3);
  }
  
  .ellipsis {
    color: #888888;
  }
  
  @media (hover: hover) {
    .page-number.active:hover {
      background: rgba(66, 153, 225, 0.3);
    }
  }
}
</style>