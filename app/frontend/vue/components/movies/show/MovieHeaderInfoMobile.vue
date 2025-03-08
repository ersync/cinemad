<script setup>
import { computed, ref, watch, nextTick } from 'vue'
import { useMovieStore } from "@/vue/stores/movieStore"
import { useUserInteractionStore } from "@/vue/stores/userInteractionStore"
import MovieActionsPanelMobile from "./MovieActionsPanelMobile.vue"

const props = defineProps({
  movieSlug: {
    type: String,
    required: true
  }
})

const movieStore = useMovieStore()
const { data: movieData } = movieStore.movieComputed(props.movieSlug)

const showActionsPanel = ref(false)
const activeTab = ref('overview')
const overviewHeight = ref(0)
const crewHeight = ref(0)
const overviewRef = ref(null)
const crewRef = ref(null)

const updateHeights = () => {
  if (overviewRef.value) {
    overviewHeight.value = overviewRef.value.scrollHeight
  }
  if (crewRef.value) {
    crewHeight.value = crewRef.value.scrollHeight
  }
}

watch(() => movieData.value, () => {
  nextTick(updateHeights)
}, { deep: true })

watch(activeTab, () => {
  nextTick(updateHeights)
})

const contentHeight = computed(() => {
  return Math.max(overviewHeight.value, crewHeight.value)
})

const formatDuration = (minutes) => {
  const hours = Math.floor(minutes / 60)
  const mins = String(minutes % 60).padStart(2, '0')
  return `${hours}h ${mins}m`
}

const formatDate = (dateString) => {
  return dateString ? new Date(dateString).toLocaleDateString('en-GB') : ''
}

const formatYear = (dateString) => {
  return dateString ? new Date(dateString).getFullYear() : ''
}

const uniqueCrewMembers = computed(() => {
  if (!movieData.value?.crew) return []

  const crewMap = new Map()
  movieData.value.crew.forEach(member => {
    if (crewMap.has(member.id)) {
      const existingRoles = crewMap.get(member.id).roles
      if (!existingRoles.includes(member.role)) {
        existingRoles.push(member.role)
      }
    } else {
      crewMap.set(member.id, {
        id: member.id,
        name: member.name,
        roles: [member.role]
      })
    }
  })

  return Array.from(crewMap.values())
})
</script>

<template>
  <div class="mt-6 space-y-4">
    <!-- Title section -->
    <div class="relative mb-8 group">
      <h2 class="flex flex-wrap items-center gap-3">
        <span class="text-3xl font-bold tracking-tight leading-tight
                     bg-gradient-to-r from-white to-white/90
                     bg-clip-text text-transparent
                     drop-shadow-[0_2px_8px_rgba(0,0,0,0.1)] line-clamp-3 max-w-[250px]">
          {{ movieData?.title }}
        </span>

        <span class="text-lg font-light px-1.5 py-0.5 rounded-md
                     bg-white/10 backdrop-blur-sm
                     text-white/80 transition-colors duration-300
                     group-hover:bg-white/15">
          {{ formatYear(movieData?.release_date) }}
        </span>
      </h2>

      <div class="absolute -bottom-2 left-0 h-[2px] w-16
                  bg-gradient-to-r from-white/80 to-transparent
                  group-hover:w-24 transition-all duration-300">
      </div>
    </div>

    <!-- Actions Panel Section -->
    <div v-show="!showActionsPanel">
      <div class="flex items-center justify-between">
        <div class="flex items-center gap-2">
          <div class="w-12 h-12 bg-white/10 rounded-full animate-pulse"/>
          <div class="h-4 w-20 bg-white/10 rounded animate-pulse"/>
        </div>

        <div class="flex items-center gap-3 pr-8">
          <div class="w-8 h-8 bg-white/10 rounded-full animate-pulse"/>
          <div class="w-8 h-8 bg-white/10 rounded-full animate-pulse"/>
          <div class="flex gap-0.5">
            <div v-for="i in 5" :key="i" class="w-4 h-4 bg-white/10 rounded-full animate-pulse"/>
          </div>
        </div>
      </div>
    </div>

    <MovieActionsPanelMobile
        v-show="showActionsPanel"
        :movie-slug="props.movieSlug"
        @panel-mounted="showActionsPanel = true"
        class="backdrop-blur-md bg-white/10 rounded-2xl
               shadow-[0_8px_32px_rgba(0,0,0,0.12)]
               border border-white/20"
    />

    <!-- Movie Details Section -->
    <div class="space-y-6 mt-30">
      <div class="flex items-center space-x-3 text-sm text-white/70">
        <span class="px-2 py-1 rounded bg-white/10 font-medium">
          {{ movieData?.age_rating }}
        </span>
        <span>{{ formatDate(movieData?.release_date) }}</span>
        <span class="w-1 h-1 rounded-full bg-white/40"/>
        <span>{{ formatDuration(movieData?.duration) }}</span>
      </div>

      <!-- Categories -->
      <div class="flex items-center text-sm">
        <span class="shrink-0 mr-3 text-indigo-400 transition-transform hover:scale-110">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"/>
          </svg>
        </span>

        <div class="flex items-center space-x-2">
          <template v-for="(category, index) in movieData?.categories" :key="category">
            <span class="text-white/70 hover:text-indigo-400 transition-colors duration-300">
              {{ category[0].toUpperCase() + category.slice(1) }}
            </span>
            <span v-if="index !== (movieData?.categories?.length - 1)" class="text-white/20">|</span>
          </template>
        </div>
      </div>

      <!-- Tagline -->
      <div v-if="movieData?.tagline"
           class="relative group py-2 flex justify-center cursor-default select-none">
        <p class="px-1 text-base italic text-transparent bg-clip-text
                  bg-gradient-to-r from-white/90 via-white/70 to-white/90
                  transition-all duration-500 ease-out
                  group-hover:from-white group-hover:to-white/90">
          "{{ movieData?.tagline }}"
        </p>

        <div class="absolute -bottom-1 left-1/2 -translate-x-1/2 w-16 h-[1px]
                    bg-gradient-to-r from-transparent via-white/20 to-transparent
                    group-hover:w-full transition-all duration-500 ease-out"/>

        <div class="absolute inset-0 bg-white/5 blur-2xl rounded-full
                    opacity-0 group-hover:opacity-10 transition-opacity duration-500"/>
      </div>

      <!-- Tabs -->
      <div class="border-b border-white/10">
        <div class="flex space-x-4">
          <button
              v-for="tab in ['overview', 'crew']"
              :key="tab"
              @click="activeTab = tab"
              class="px-4 py-2 text-sm font-medium transition-all duration-300"
              :class="[
                activeTab === tab
                  ? 'text-white border-b-2 border-white'
                  : 'text-white/60 hover:text-white/80'
              ]"
          >
            {{ tab.charAt(0).toUpperCase() + tab.slice(1) }}
          </button>
        </div>
      </div>

      <!-- Tab content -->
      <div
          class="text-sm sm:text-base pt-4 pb-8"
          :style="{ minHeight: `${contentHeight}px` }"
      >
        <div
            v-if="activeTab === 'overview'"
            ref="overviewRef"
            class="h-full"
        >
          <p class="leading-relaxed text-white/90">
            {{ movieData?.overview }}
          </p>
        </div>

        <div
            v-else-if="activeTab === 'crew'"
            ref="crewRef"
            class="grid grid-cols-2 gap-4 h-full"
        >
          <div
              v-for="crewMember in uniqueCrewMembers"
              :key="crewMember.id"
              class="p-4 rounded-lg bg-white/5 backdrop-blur-sm"
          >
            <h4 class="font-medium text-white">{{ crewMember.name }}</h4>
            <p class="text-sm text-white/70">{{ crewMember.roles.join(", ") }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>