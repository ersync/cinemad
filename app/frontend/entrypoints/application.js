import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { useAuthStore } from '@/vue/stores/authStore'
import App from '@/vue/App.vue'
import router from "@/vue/router"

import '@/scripts/header.js'
import '@/scripts/theme_toggle.js'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  const pinia = createPinia()
  app.use(pinia)
  app.use(router)
  app.mount('#app')
  
  window.addEventListener('app:logout', () => {
    const authStore = useAuthStore()
    authStore.logout()
  })
})