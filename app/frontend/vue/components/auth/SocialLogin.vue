<script setup>
import { ref } from 'vue'
import { useAuthStore } from '@/vue/stores/authStore'

const authStore = useAuthStore()
const loading = ref(false)
const currentProvider = ref(null)

const providers = [
  { id: 'google', name: 'Google' },
  { id: 'apple', name: 'Apple', disabled: true }
]

async function handleSocialLogin(providerId) {
  if (loading.value) return
  
  loading.value = true
  currentProvider.value = providerId
  
  try {
    if (providerId === 'google') {
      await authStore.loginWithGoogle()
    } else if (providerId === 'apple') {
      console.log('Apple sign-in not yet implemented')
    }
  } catch (error) {
    console.error(`${providerId} login failed:`, error)
  } finally {
    loading.value = false
    currentProvider.value = null
  }
}
</script>

<template>
  <div class="!mt-4 sm:!mt-5">
    <div class="relative">
      <div class="absolute inset-0 flex items-center">
        <div class="w-full border-t border-gray-200 dark:border-gray-700"></div>
      </div>
      <div class="relative flex justify-center text-sm">
        <span class="px-2 bg-white dark:bg-gray-800 text-[#202035]/60 dark:text-gray-400">Or continue with</span>
      </div>
    </div>

    <div class="mt-6 grid grid-cols-2 gap-3">
      <button
          v-for="provider in providers"
          :key="provider.name"
          type="button"
          @click="handleSocialLogin(provider.id)"
          :disabled="loading || provider.disabled"
          :class="[
            'w-full inline-flex justify-center items-center px-3 py-2 sm:px-4 sm:py-2.5 rounded-xl',
            'border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-700 text-[#202035]/80 dark:text-gray-200',
            'transition-colors duration-200 shadow-sm gap-2',
            provider.disabled 
              ? 'opacity-50 cursor-not-allowed' 
              : 'hover:bg-gray-50 dark:hover:bg-gray-600'
          ]"
      >
        <svg v-if="provider.id === 'google'" class="h-5 w-5" viewBox="0 0 24 24">
          <path
              d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
              fill="#4285F4"
          />
          <path
              d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
              fill="#34A853"
          />
          <path
              d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
              fill="#FBBC05"
          />
          <path
              d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
              fill="#EA4335"
          />
        </svg>
        <svg v-if="provider.id === 'apple'" class="h-5 w-5" viewBox="0 0 384 512">
          <path
              d="M318.7 268.7c-.2-36.7 16.4-64.4 50-84.8-18.8-26.9-47.2-41.7-84.7-44.6-35.5-2.8-74.3 20.7-88.5 20.7-15 0-49.4-19.7-76.4-19.7C63.3 141.2 4 184.8 4 273.5q0 39.3 14.4 81.2c12.8 36.7 59 126.7 107.2 125.2 25.2-.6 43-17.9 75.8-17.9 31.8 0 48.3 17.9 76.4 17.9 48.6-.7 90.4-82.5 102.6-119.3-65.2-30.7-61.7-90-61.7-91.9zm-56.6-164.2c27.3-32.4 24.8-61.9 24-72.5-24.1 1.4-52 16.4-67.9 34.9-17.5 19.8-27.8 44.3-25.6 71.9 26.1 2 49.9-11.4 69.5-34.3z"
              class="text-black dark:text-white fill-current"
          />
        </svg>
        <span v-if="loading && currentProvider === provider.id" class="inline-block animate-spin mr-2">
          <i class="fas fa-circle-notch"></i>
        </span>
        {{ provider.name }}
      </button>
    </div>
  </div>
</template>