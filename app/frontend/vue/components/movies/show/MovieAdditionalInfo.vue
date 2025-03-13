<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useMovieStore } from '@/vue/stores/movieStore'

const route = useRoute()
const movieStore = useMovieStore()
const movieSlug = computed(() => route.params.slug)
const { data: movieData } = movieStore.movieComputed(movieSlug.value)

function formatDate(dateString) {
  if (!dateString) return 'Unknown'
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

function formatCurrency(amount) {
  if (!amount) return 'Unknown'
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0
  }).format(amount)
}

function formatLanguage(code) {
  if (!code) return 'Unknown'
  const languages = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh': 'Chinese'
  }
  return languages[code] || code
}

const socialLinks = ref([
  { icon: 'facebook', url: '#', label: 'Facebook' },
  { icon: 'twitter', url: '#', label: 'Twitter' },
  { icon: 'instagram', url: '#', label: 'Instagram' }
])

const movieFacts = computed(() => {
  const movie = movieData.value
  if (!movie) return []

  return [
    {
      label: 'Status',
      value: movie.status || 'Released'
    },
    {
      label: 'Original Language',
      value: formatLanguage(movie.language)
    },
    {
      label: 'Production Budget',
      value: formatCurrency(movie.budget)
    },
    {
      label: 'Box Office Revenue',
      value: formatCurrency(movie.revenue)
    },
    {
      label: 'Release Date',
      value: formatDate(movie.release_date)
    }
  ].filter(fact => fact.value !== 'Unknown')
})

const keywords = computed(() =>
    movieData.value?.categories || []
)
</script>

<template>
  <div class="min-w-[295px] lg:max-w-[281px] mx-auto sm:p-4 pt-0">
    <div class="rounded-2xl max-sm:p-4 max-sm:pl-2">
      <div class="flex justify-center mb-12">
        <div class="inline-flex items-center gap-3 px-4 py-2 bg-white/80 rounded-full">
          <a v-for="social in socialLinks"
             :key="social.icon"
             :href="social.url"
             :aria-label="social.label"
             class="p-2 text-gray-600">
            <svg class="w-6 h-6">
              <use :href="`#${social.icon}`"></use>
            </svg>
          </a>

          <div class="mx-1 w-px h-4 bg-gray-200"></div>

          <a href="#"
             aria-label="Watch on JustWatch"
             class="p-2 text-gray-500">
            <svg class="w-4 h-4">
              <use href="#justwatch"></use>
            </svg>
          </a>

          <div class="mx-1 w-px h-4 bg-gray-200"></div>

          <a href="#"
             aria-label="Copy link"
             class="p-2 text-gray-500">
            <svg class="w-4 h-4">
              <use href="#link"></use>
            </svg>
          </a>
        </div>
      </div>

      <div v-if="movieFacts.length" class="mb-12 divide-y divide-gray-100">
        <div v-for="fact in movieFacts"
             :key="fact.label"
             class="py-4 first:pt-0 last:pb-0">
          <div class="grid grid-cols-[1fr,auto] gap-4 items-center">
            <div class="flex items-center gap-3">
              <div class="w-1 h-1 rounded-full bg-indigo-300"></div>
              <span class="text-sm text-gray-500">{{ fact.label }}</span>
            </div>
            <span class="text-sm font-medium text-gray-900">{{ fact.value }}</span>
          </div>
        </div>
      </div>

      <div v-if="keywords.length">
        <h4 class="flex items-center gap-2 mb-4 text-sm text-gray-500">
          <div class="w-1 h-1 rounded-full bg-indigo-300"></div>
          Keywords
        </h4>
        <div class="flex flex-wrap gap-2">
          <span
              v-for="keyword in keywords"
              :key="keyword"
              class="px-3.5 py-1.5 text-xs font-medium bg-gray-50 text-gray-600
                   rounded-full ring-1 ring-gray-100">
            {{ keyword }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>