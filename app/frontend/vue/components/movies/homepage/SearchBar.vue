<template>
  <div class="relative w-full search-container">
    <form @submit.prevent="handleSearch" class="w-full flex mt-[50px]">
      <div class="relative flex w-full">
        <div class="absolute z-10 left-4 top-1/2 -translate-y-1/2 text-gray-400">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </div>

        <input
          v-model="searchQuery"
          @input="handleInput"
          class="h-[40px] sm:h-[50px] py-2 sm:py-2.5 pl-12 pr-4 rounded-l-full bg-white/10 w-full outline-none
               text-white text-xs sm:text-base placeholder-gray-400 backdrop-blur-sm border border-white/20
               focus:border-white/40 transition-all duration-300"
          type="text"
          placeholder="Search for movies..."
        >
        <button
          class="h-[40px] sm:h-[50px] -ml-0.5 z-10 px-4 sm:px-8 rounded-r-full font-semibold text-xs sm:text-base
         text-white transition-all duration-300 hover:opacity-90 hover:shadow-lg border border-white/20
         hover:border-white/40"
          :style="gradientStyle"
        >
          Search
        </button>
      </div>
    </form>

    <SearchResults
      :query="searchQuery"
      :visible="showResults"
      containerClass="absolute w-full mt-2"
      @select="goToMovie"
    />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import SearchResults from '@/vue/components/SearchResults.vue'

const router = useRouter()
const searchQuery = ref('')
const showResults = ref(false)

const handleInput = () => {
  showResults.value = searchQuery.value.length > 0
}

const handleSearch = () => {
  if (searchQuery.value) {
    router.push({
      name: 'search-results',
      query: { q: searchQuery.value }
    })
    showResults.value = false
  }
}

const goToMovie = (slug) => {
  router.push(`/movies/${slug}`)
  searchQuery.value = ''
  showResults.value = false
}

const handleClickOutside = (event) => {
  if (!event.target.closest('.search-container')) {
    showResults.value = false
  }
}

const gradientStyle = {
  background: 'linear-gradient(to right, #01121f, #012645, #01121f)'
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside)
})
</script>