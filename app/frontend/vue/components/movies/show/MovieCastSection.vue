<template>
  <div class="mb-[30px] pb-[30px] border-b border-[#d7d7d7] antialiased">
    <h3 class="font-SourceProSemiBold text-[1.2rem] sm:text-[1.4rem] mb-3">
      Top Billed Cast
    </h3>

    <div class="relative">
      <CastSkeleton v-if="loading" />
      <CastList
          v-else
          :cast="castMembers"
          class="mb-5"
      />
    </div>

    <button
        class="block text-[1.1rem] font-SourceProSemiBold mt-5"
        @click="$emit('showFullCast')"
    >
      Full Cast & Crew
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import CastSkeleton from './CastSkeleton.vue'
import CastList from './CastList.vue'

const props = defineProps({
  movieId: {
    type: String,
    required: true
  }
})

defineEmits(['showFullCast'])

const loading = ref(true)
const castMembers = ref([])

const fetchCast = async () => {
  try {
    loading.value = true
    const response = await axios.get(`/api/movies/${props.movieId}/cast`)
    castMembers.value = response.data
  } catch (error) {
    console.error('Failed to fetch cast:', error)
  } finally {
    loading.value = false
  }
}

onMounted(fetchCast)
</script>