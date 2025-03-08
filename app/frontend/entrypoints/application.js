import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from '@/vue/App.vue'
import router from "@/vue/router"

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  const pinia = createPinia()

  app.use(pinia)
  app.use(router)
  app.mount('#app')
})