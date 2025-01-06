<template>
  <div class="font-SourceProNormal scrollbar overflow-scroll">
    <ul class="flex gap-3.5 mb-2.5 h-[268px] shimmer-fast">
      <CastSkeletonItem v-for="n in 10" :key="n" />
    </ul>
  </div>
</template>

<script setup>
import CastSkeletonItem from '@/vue/components/movies/show/CastSkeletonItem.vue'
</script>