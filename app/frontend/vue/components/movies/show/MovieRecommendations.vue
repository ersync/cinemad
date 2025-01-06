<template>
  <section class="relative" aria-labelledby="recommendations-heading">
    <h3 id="recommendations-heading" class="text-[1.4em] font-SourceProSemiBold mb-5">
      Recommendations
    </h3>

    <div class="scrollable-wrapper fading scrollbar overflow-x-auto">
      <ul v-if="recommendations.length" class="scrollable-content flex gap-4 pb-2.5 snap-x snap-mandatory">
        <RecommendationCard
            v-for="movie in recommendations"
            :key="movie.id"
            :movie="movie"
        />
      </ul>
      <RecommendationsSkeleton v-else />
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import RecommendationCard from '@/vue/components/movies/show/RecommendationCard.vue'
import RecommendationsSkeleton from '@/vue/components/movies/show/RecommendationsSkeleton.vue'

const props = defineProps({
  movieId: {
    type: String,
    required: true
  }
})

const recommendations = ref([])

const fetchRecommendations = async () => {
  try {
    const response = await axios.get(`/api/movies/${props.movieId}/recommendations`)
    recommendations.value = response.data
  } catch (error) {
    console.error('Failed to fetch recommendations:', error)
  }
}

onMounted(fetchRecommendations)
</script>