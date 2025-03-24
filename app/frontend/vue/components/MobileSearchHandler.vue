<template>
  <div class="mobile-search-results sm:hidden">
	
	<SearchResults
	  :query="searchQuery"
	  :visible="isVisible"
	  :is-mobile="true"
	  containerClass="fixed z-50 w-[calc(100%-70px)] left-1/2 -translate-x-1/2 top-[48px]"
	  @select="handleSelect"
	/>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import SearchResults from './SearchResults.vue'

const router = useRouter()
const searchQuery = ref('')
const isVisible = ref(false)
const topPosition = ref(60) 


const handleMobileSearch = (event) => {
  searchQuery.value = event.detail.query
  isVisible.value = event.detail.query.length > 0
}

const handleClearSearch = () => {
  searchQuery.value = ''
  isVisible.value = false
}

const handleSelect = (slug) => {
  router.push(`/movies/${slug}`)
  isVisible.value = false
}



onMounted(() => {
  window.addEventListener('mobile-search-input', handleMobileSearch)
  window.addEventListener('mobile-search-clear', handleClearSearch)
  
})

onUnmounted(() => {
  window.removeEventListener('mobile-search-input', handleMobileSearch)
  window.removeEventListener('mobile-search-clear', handleClearSearch)
})
</script>