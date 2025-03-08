<template>
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div class="bg-gradient-to-br from-[#032541] via-[#034275] to-[#032541] rounded-xl p-6
        shadow-lg border border-white/5">
      <div class="text-center">
        <div class="text-3xl font-SourceProSemiBold text-white/95">
          {{ user.avg_rating }}%
        </div>
        <div class="text-sm text-white/70 font-medium mt-1.5">Your Average Rating</div>
      </div>
    </div>
    <div class="bg-gradient-to-br from-[#032541] via-[#034275] to-[#032541] rounded-xl p-6
        shadow-lg border border-white/5">
      <div class="text-center">
        <div class="text-3xl font-SourceProSemiBold text-white/95">
          {{ user.stats?.total_ratings || 0 }}
        </div>
        <div class="text-sm text-white/70 font-medium mt-1.5">Total Ratings</div>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  user: {
    type: Object,
    required: true
  }
})
</script>