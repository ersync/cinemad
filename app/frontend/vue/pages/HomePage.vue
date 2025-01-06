<template>
  <div class="antialiased font-SourceProNormal">
    <!-- Hero Section -->
    <div
        class="flex justify-center items-start flex-col h-[357px] text-white antialiased p-10 my-auto"
        :style="heroBackgroundStyle"
    >
      <div class="container">
        <h2 class="font-SourceProBold text-[3rem] leading-10">Welcome</h2>
        <h3 class="font-SourceProSemiBold text-[2rem]">
          Millions of movies, TV shows and people to discover. Explore now.
        </h3>
        <form @submit.prevent="handleSearch" class="w-full flex mt-[50px]">
          <input
              v-model="searchQuery"
              class="h-[46px] py-2.5 px-4 rounded-l-full bg-white w-full outline-none !text-tmdbDarkBlue"
              type="text"
              placeholder="Search for a movie, tv show, person......."
          >
          <button
              class="w-[100px] -ml-6 shrink-0 rounded-full font-SourceProBold"
              :style="gradientStyle"
          >
            Search
          </button>
        </form>
      </div>
    </div>
    <!-- Content Section -->
    <div class="container">

      <movie-carousel
          :movies="trendingMovies"
          title="Trending"
          :periods="['Today', 'This Week']"
          :show-scrollbar="false"
          height="450px"
          :background-bar="true"
      />

<!--      <trailers-menu />-->

      <movie-carousel
          :movies="popularMovies"
          title="What's Popular"
          :periods="['Streaming', 'On TV', 'For Rent', 'In Theaters']"
          :show-scrollbar="false"
      />

      <movie-carousel
          :movies="freeMovies"
          title="Free To Watch"
          :periods="['Movies', 'TV']"
          :show-scrollbar="false"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import MovieCarousel from '@/vue/components/MovieCarousel.vue'

// Reactive state
const searchQuery = ref('')
const trendingMovies = ref([])
const popularMovies = ref([])
const freeMovies = ref([])

// Computed styles
const heroBackgroundStyle = computed(() => ({
  background: "url('https://media.themoviedb.org/t/p/w1920_and_h600_multi_faces_filter(duotone,00192f,00baff)/e3h0knvtz4qPg9dwYdWynALrW9s.jpg') 0 / cover no-repeat"
}))

const gradientStyle = computed(() => ({
  background: "linear-gradient(to right,rgba(30,213,169,1) 0%,rgba(1,180,228,1) 100%)"
}))

// Methods
const handleSearch = () => {
  console.log('Searching for:', searchQuery.value)
  // Implement search logic
}

// Fetch movies data
const fetchMovies = async () => {
  try {
    const response = await fetch('/api/movies')
    const data = await response.json()

    trendingMovies.value = data.trending || []
    popularMovies.value = data.popular || []
    freeMovies.value = data.free || []
  } catch (error) {
    console.error('Error fetching movies:', error)
  }
}

// Fetch data on component mount
fetchMovies()
</script>