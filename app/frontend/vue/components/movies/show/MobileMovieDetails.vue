<template>
  <div>
    <div
        class="flex flex-col text-[1rem] justify-center items-center p-2.5 shadow-light"
        :style="{ backgroundColor: movie.gradientColor }"
    >
      <div class="flex justify-center items-center">
        <span class="text-white/80 text-[0.8rem] border border-white/50 inline-flex justify-center items-center pb-[1px] px-1 rounded-sm leading-4">
          {{ movie.ageRating }}
        </span>
        <span class="disc relative ml-5"></span>
        <span>{{ formattedReleaseDate }} (GB)</span>
        <span class="disc relative ml-5"></span>
        <span>{{ formattedDuration }}</span>
      </div>
      <div>
        <span>{{ formattedCategories }}</span>
      </div>
    </div>
    <div class="p-5">
      <p class="text-[1.1rem] italic text-white/70 leading-4 mb-3">{{ movie.tagline }}</p>
      <div>
        <h3 class="text-[1.3rem] font-SourceProSemiBold mt-2.5 mb-2">Overview</h3>
        <p class="leading-6 font-SourceProNormal opacity-90">{{ movie.overview }}</p>
        <ul class="grid grid-cols-2 gap-y-5 font-SourceProBold mt-5">
          <li
              v-for="crewMember in uniqueCrew"
              :key="crewMember.id"
              class="flex [&:nth-child(even)]:justify-center"
          >
            {{ displayCrewInformation(crewMember) }}
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  movie: {
    type: Object,
    required: true
  },
  crew: {
    type: Array,
    required: true
  }
})

const formattedReleaseDate = computed(() => {
  const date = new Date(props.movie.releaseDate)
  return date.toLocaleDateString('en-GB')
})

const formattedDuration = computed(() => {
  const hours = Math.floor(props.movie.duration / 60)
  const minutes = props.movie.duration % 60
  return `${hours}h ${minutes.toString().padStart(2, '0')}m`
})

const formattedCategories = computed(() => {
  return props.movie.categories
      .map(category => category.name)
      .map(name => name.charAt(0).toUpperCase() + name.slice(1))
      .join(', ')
})

const uniqueCrew = computed(() => {
  return [...new Set(props.crew)]
})

const displayCrewInformation = (crewMember) => {
  return `${crewMember.name} - ${crewMember.role}`
}
</script>