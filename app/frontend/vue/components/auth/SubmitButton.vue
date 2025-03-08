<template>
  <button
      type="submit"
      :disabled="loading"
      class="group relative w-full flex justify-center py-2 px-3 sm:py-3 sm:px-4
           text-sm font-medium rounded-xl text-white
           bg-gradient-to-r from-[#1a1b2e] via-[#1d2339] to-[#1f2a45]
           hover:from-[#1d1e32] hover:via-[#20263f] hover:to-[#22304e]
           focus:outline-none transition-all duration-200
           disabled:opacity-50 disabled:cursor-not-allowed
           shadow-[0_2px_10px_rgba(0,0,0,0.1)]"
  >
    <span class="absolute inset-y-0 left-0 flex items-center pl-3">
      <i :class="icon" class="fas text-white/60"></i>
    </span>
    <span v-if="loading" class="flex items-center">
      <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
      </svg>
      {{ loadingText }}
    </span>
    <span v-else>{{ text }}</span>
  </button>
</template>

<script setup>
defineProps({
  loading: Boolean,
  icon: String,
  text: String,
  loadingText: String
})
</script>