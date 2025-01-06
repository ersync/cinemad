<script setup>
import { provide, ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import MovieHeader from '@/vue/components/movies/show/MovieHeader.vue'
import MovieCastSection from "@/vue/components/movies/show/MovieCastSection.vue"
import MovieSocial from "@/vue/components/movies/show/MovieSocial.vue"
import MovieRecommendations from "@/vue/components/movies/show/MovieRecommendations.vue"
import MovieMedia from "@/vue/components/movies/show/MovieMedia.vue"
import MovieAdditionalInfo from "@/vue/components/movies/show/MovieAdditionalInfo.vue"
const route = useRoute()
const movieId = ref(null)
const movieData = ref(null)
const isLoading = ref(true)

const fetchMovie = async (id) => {
  try {
    const response = await fetch(`/api/movies/${id}`)
    movieData.value = await response.json()
  } catch (error) {
    console.error('Error fetching movie:', error)
  } finally {
    isLoading.value = false
  }
}

onMounted(async () => {
  movieId.value = route.params.id
  provide('movieId', movieId)
  provide('movieData', movieData)
  await fetchMovie(movieId.value)
  console.log(movieData)
})
</script>

<template>
  <div v-if="movieData">
    <MovieHeader :movie-id="movieId" />
    <div class="container">
      <div class="flex flex-col lg:flex-row gap-x-3.5 lg:gap-x-[30px] gap-y-8 my-[30px]">
        <!-- Left Side -->
        <div class="font-SourceProNormal overflow-hidden">
          <!-- Cast Section -->
          <MovieCastSection :movie-id="movieId" />

          <!-- Social Section -->
          <MovieSocial
              :movie-id="movieId"
          />

          <!-- Media Section -->
          <MovieMedia></MovieMedia>

          <!-- Collection Section -->
<!--          <div class="bg-gray-100 p-4 mb-4">-->
<!--            <h3>Collection Section</h3>-->
<!--            <p>Collection info will go here (if exists)</p>-->
<!--          </div>-->

          <!-- Recommendations Section -->
          <MovieRecommendations :movie-id="movieId" />
        </div>

        <!-- Right Side -->
        <div class="min-w-[260px] lg:max-w-[261px] mx-auto p-4 mt-16">
          <MovieAdditionalInfo></MovieAdditionalInfo>
        </div>
      </div>
    </div>
  </div>
  <div v-else>
    Loading...
  </div>
</template>