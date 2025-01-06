<template>
  <div class="mb-[30px] pb-[30px] border-b border-[#d7d7d7]">
    <SocialTabs
        v-if="socialData"
        :review-count="socialData.stats.review_count"
        :discussion-count="socialData.stats.discussion_count"
        :active-tab="activeTab"
        @tab-change="handleTabChange"
    />

    <TheFeaturedReview
        v-if="socialData?.featured_review"
        :review="socialData.featured_review"
    />

    <button
        class="block text-[1.1rem] font-SourceProSemiBold mt-5"
        @click="$emit('showAllReviews')"
    >
      Read All Reviews
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'
import SocialTabs from '@/vue/components/movies/show/SocialTabs.vue'
import TheFeaturedReview from '@/vue/components/movies/show/TheFeaturedReview.vue'

const props = defineProps({
  movieId: {
    type: String,
    required: true
  }
})

defineEmits(['showAllReviews'])

const socialData = ref(null)
const loading = ref(true)
const activeTab = ref('reviews')

const fetchSocialData = async () => {
  try {
    loading.value = true
    const response = await axios.get(`/api/movies/${props.movieId}/social`)
    socialData.value = response.data
  } catch (error) {
    console.error('Failed to fetch social data:', error)
  } finally {
    loading.value = false
  }
}

const handleTabChange = (tab) => {
  activeTab.value = tab
}

onMounted(fetchSocialData)
</script>