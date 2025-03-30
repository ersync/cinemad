<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 dark:bg-opacity-70 flex items-center justify-center z-50">
    <div class="bg-white dark:bg-gray-800 rounded-lg p-6 w-full max-w-md shadow-xl dark:shadow-black/30">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100">
          <slot name="title">Modal Title</slot>
        </h3>
        <button @click="$emit('close')" class="text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 transition-colors">
          <span class="text-2xl">&times;</span>
        </button>
      </div>
      <slot></slot>
    </div>
  </div>
</template>

<script setup>
defineEmits(['close'])
</script>