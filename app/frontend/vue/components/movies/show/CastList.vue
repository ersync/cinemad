<template>
  <div class="scrollable-wrapper font-SourceProNormal scrollbar overflow-scroll">
    <ul class="scrollable-content items-stretch flex gap-3.5">
      <CastCard
          v-for="person in cast"
          :key="person.id"
          :person="person"
      />
    </ul>
  </div>
</template>

<script setup>
import CastCard from '@/vue/components/movies/show/CastCard.vue'

defineProps({
  cast: {
    type: Array,
    required: true,
    default: () => []
  }
})
</script>