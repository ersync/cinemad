import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { useAuthStore } from '@/vue/stores/authStore'
import App from '@/vue/App.vue'
import router from "@/vue/router"

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  const pinia = createPinia()
  app.use(pinia)
  app.use(router)
  app.mount('#app')
  
  // This lets my Rails views trigger a logout in Vue
  // Rails dispatches 'app:logout' event -> Vue catches it here -> authStore handles the actual logout
  window.addEventListener('app:logout', () => {
    const authStore = useAuthStore()
    authStore.logout()
  })
})