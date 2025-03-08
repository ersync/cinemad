<template>
  <Transition
      enter-active-class="transition ease-out duration-200"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition ease-in duration-200"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
  >
    <LoadingSpinner v-if="isLoading" />
  </Transition>
</template>

<script setup>
import { storeToRefs } from 'pinia'
import { useLoadingStore } from '@/vue/stores/loadingStore'
import LoadingSpinner from '@/vue/components/LoadingSpinner.vue'

const loadingStore = useLoadingStore()
const { isLoading } = storeToRefs(loadingStore)
</script>