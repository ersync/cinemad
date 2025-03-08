import { ref, computed } from 'vue'

export function useSortedMovies(movies) {
  const currentFilter = ref('Date Added')
  const currentOrder = ref('desc')

  const sortedMovies = computed(() => {
    const movieList = movies.value || []

    return [...movieList].sort((a, b) => {
      const multiplier = currentOrder.value === 'asc' ? 1 : -1

      switch (currentFilter.value.toLowerCase()) {
        case 'date added':
          return multiplier * (new Date(a.created_at) - new Date(b.created_at))
        case 'Release Date':
          const dateA = a.release_date ? new Date(a.release_date) : new Date(0)
          const dateB = b.release_date ? new Date(b.release_date) : new Date(0)
        case 'title':
          return multiplier * a.title.localeCompare(b.title)
        case 'rating':
          return multiplier * ((b.average_rating || 0) - (a.average_rating || 0))
        default:
          return 0
      }
    })
  })

  const handleFilterChange = (filter) => {
    console.log('Applying filter:', filter, 'to', movies.value?.length, 'movies')
    currentFilter.value = filter
  }

  const handleOrderChange = (order) => {
    console.log('Applying order:', order, 'to', movies.value?.length, 'movies')
    currentOrder.value = order
  }

  return {
    sortedMovies,
    handleFilterChange,
    handleOrderChange
  }
}