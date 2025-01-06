<template>
  <div class="grid max-xs:grid-colo-1 xs:grid-cols-2 lg:grid-cols-1 gap-7 font-SourceProNormal antialiased">
    <!-- Social media and facts column -->
    <div class="space-y-7">
      <!-- Social media links -->
      <div class="flex flex-wrap justify-start max-sm:pt-1 gap-4 sm:gap-2.5 mt-1">
        <a href="#" v-for="social in socialLinks" :key="social.icon">
          <svg class="w-6 h-6 sm:w-7 sm:h-7">
            <use :href="`#${social.icon}`"></use>
          </svg>
        </a>
        <div class="flex gap-2.5">
          <div>
            <a href="#">
              <svg class="w-6 h-6 sm:w-7 sm:h-7">
                <use xlink:href="#justwatch"></use>
              </svg>
            </a>
          </div>
          <div class="sm:pl-2.5 sm:border-l border-tmdbLightGray">
            <a href="#">
              <svg class="w-7 h-7 sm:w-8 sm:h-8">
                <use href="#link"></use>
              </svg>
            </a>
          </div>
        </div>
      </div>

      <!-- Movie facts -->
      <div>
        <ul class="space-y-5">
          <li v-for="fact in movieFacts" :key="fact.label">
            <strong class="font-SourceProSemiBold block">{{ fact.label }}:</strong>
            <span class="text-black/80">{{ fact.value }}</span>
          </li>
        </ul>
      </div>

      <!-- Keywords -->
      <div>
        <h4 class="text-[1.1rem] font-SourceProSemiBold mb-2.5 mt-5">Keywords</h4>
        <ul class="flex gap-x-1 gap-y-2.5 flex-wrap child:tag pb-[30px] lg:border-b lg:border-[#d7d7d7]">
          <li v-if="keywords.length"
              v-for="keyword in keywords"
              :key="keyword"
              class="text-[0.9rem] cursor-pointer">
            {{ keyword }}
          </li>
          <li v-else class="text-[0.9rem] text-gray-500">
            No keywords available
          </li>
        </ul>
      </div>
    </div>

    <!-- Content Score and Contributors column -->
    <div>
      <!-- Content Score -->
      <div class="mb-[30px]">
        <h4 class="text-[1.1rem] font-SourceProSemiBold mb-1">Content Score</h4>
        <div class="rounded-lg overflow-hidden">
          <p class="bg-black text-white font-SourceProBold leading-8 sm:leading-9 px-3">100</p>
          <p class="pt-0.5 pb-1 px-3 bg-black/15 text-[0.85rem] sm:text-[0.9rem]">Yes! Looking good!</p>
        </div>
      </div>

      <!-- Top Contributors -->
      <div class="mb-[30px]">
        <h4 class="text-[1.1rem] font-SourceProSemiBold mb-1">Top Contributors</h4>
        <ul class="space-y-5">
          <li v-for="contributor in topContributors"
              :key="contributor.id"
              class="flex justify-start items-center gap-2.5">
            <div class="rounded-full overflow-hidden h-11 w-11">
              <img :src="contributor.avatar" :alt="contributor.name">
            </div>
            <div>
              <p class="font-SourceProSemiBold leading-5">{{ contributor.score }}</p>
              <p class="font-SourceProLight">{{ contributor.name }}</p>
            </div>
          </li>
        </ul>
      </div>
    </div>

    <!-- Additional Actions Column -->
    <div class="text-center max-xs:col-span-1 col-span-2 lg:col-span-1">
      <!-- Login button -->
      <div class="inline-flex justify-center items-center gap-1.5 mb-[30px] bg-black py-1.5 px-5 rounded-full text-white text-center">
        <svg class="w-[15.84px] h-[15.84px]">
          <use xlink:href="#lock"></use>
        </svg>
        <a class="text-[15.84pxx] font-SourceProBold uppercase" href="">Login To Edit</a>
      </div>

      <!-- Keyboard Shortcuts -->
      <div class="flex justify-center items-center gap-1 mb-5 opacity-50">
        <svg class="w-[1.4rem] h-[1.4rem]">
          <use xlink:href="#keyboard"></use>
        </svg>
        <a href="">Keyboard Shortcuts</a>
      </div>

      <!-- Report Issue -->
      <div class="flex justify-center items-center gap-1">
        <svg class="w-[1.4rem] h-[1.4rem]">
          <use xlink:href="#speech-bubble"></use>
        </svg>
        <p>Login to report an issue</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, inject } from 'vue'
import { useMovieStore } from '@/vue/stores/movieStore'

const movieId = inject('movieId')
const movieStore = useMovieStore()

const socialLinks = ref([
  { icon: 'facebook', url: '#' },
  { icon: 'twitter', url: '#' },
  { icon: 'instagram', url: '#' }
])

const movieFacts = ref([
  { label: 'Status', value: 'Released' },
  { label: 'Original Language', value: 'English' },
  { label: 'Budget', value: '$200,000,000' },
  { label: 'Revenue', value: '$1,000,000,000' }
])

const keywords = ref([
  'action',
  'adventure',
  'sci-fi',
  'thriller'
])

const topContributors = ref([
  {
    id: 1,
    name: 'raze464',
    score: 875,
    avatar: 'https://www.themoviedb.org/t/p/w45_and_h45_face/yYG7Rhn9HfFpssIMeNiDynvxC14.jpg'
  },
  {
    id: 2,
    name: 'raze464',
    score: 875,
    avatar: 'https://www.themoviedb.org/t/p/w45_and_h45_face/yYG7Rhn9HfFpssIMeNiDynvxC14.jpg'
  },
  {
    id: 3,
    name: 'raze464',
    score: 875,
    avatar: 'https://www.themoviedb.org/t/p/w45_and_h45_face/yYG7Rhn9HfFpssIMeNiDynvxC14.jpg'
  },
  {
    id: 4,
    name: 'raze464',
    score: 875,
    avatar: 'https://www.themoviedb.org/t/p/w45_and_h45_face/yYG7Rhn9HfFpssIMeNiDynvxC14.jpg'
  }
])
</script>

<style scoped>
.tag {
  @apply bg-tmdbLightGray/50 py-1 px-3 rounded-[4px];
}
</style>