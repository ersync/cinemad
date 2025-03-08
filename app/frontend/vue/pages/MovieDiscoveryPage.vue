<template>
  <div class="container antialiased mb-40">
    <h1 class="font-SourceProSemiBold text-[1.6rem] mt-7.5 mb-5">Discovery</h1>
    <div class="flex items-center sm:items-start justify-center flex-col sm:flex-row max-sm:gap-6">
      <FilterForm
          :initial-filters="filters"
          @search="handleSearch"
      />
      <FilterResults
          :movies="movies"
          :loading="loading"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { movieApiService } from '@/services/movieApiService'
import FilterForm from '@/vue/components/movies/discovery/FilterForm.vue'
import FilterResults from '@/vue/components/movies/discovery/FilterResults.vue'

const movies = ref([])
const loading = ref(false)
const filters = ref({
  sort: 'popularity_desc',
  page: 1,
  per_page: 20,
  filter: {
    watch_status: '',
    availabilities: {},
    release_formats: [],
    date_from: '',
    date_to: '',
    genres: [],
    certifications: [],
    language: '',
    selected_keywords: '',
    all_availabilities: '0',
    all_release_formats: '0'
  }
})

const handleSearch = async (newFilters) => {
  loading.value = true
  try {
    const searchParams = {
      sort: newFilters.sort,
      page: filters.value.page,
      per_page: filters.value.per_page,
      filter: newFilters.filter || {}
    }

    const response = await movieApiService.getDiscoveryMovies(searchParams)
    movies.value = response.movies
    console.log('Movies assigned:',  movies.value)
    console.log('FOUND', movies.value)
  } catch (error) {
    console.error('Error fetching movies:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  handleSearch(filters.value)
})
</script>