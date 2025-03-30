<template>
  <div class="bg-white dark:bg-gray-800 rounded-xl shadow-sm dark:shadow-gray-900/20 p-6">
    <div class="flex justify-between items-center mb-6">
      <h3 class="text-xl font-bold text-gray-900 dark:text-gray-100">Recent Activity</h3>
    </div>

    <div v-if="!activities.length" class="text-center py-8 text-gray-500 dark:text-gray-400">
      <svg class="w-16 h-16 mx-auto mb-4 text-gray-400 dark:text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
      <p class="text-lg font-medium">No recent activity</p>
      <p class="mt-2">Rate some movies to see your activity here</p>
    </div>

    <div v-else class="space-y-4">
    </div>
  </div>
</template>

<script setup>
defineProps({
  activities: {
    type: Array,
    required: true,
    default: () => []
  }
})
</script>