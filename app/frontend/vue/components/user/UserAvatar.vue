<template>
  <span v-if="!imageUrl"
        class="flex items-center justify-center w-14 h-14 rounded-full bg-gradient-to-r from-blue-500 to-purple-500 text-lg font-semibold text-white shadow-lg ring-2 ring-white/30 hover:ring-white/20 transition-all duration-200">
    {{ username[0].toUpperCase() }}
  </span>
  <img v-else
       :src="imageUrl"
       :alt="username"
       class="w-full h-full object-cover transition-transform duration-300 ease-in-out">
</template>

<script setup>
defineProps({
  imageUrl: String,
  username: {
    type: String,
    required: true
  }
})
</script>