// app/frontend/vue/initializers/vueAppInitializer.js
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from '@/vue/App.vue'
import router from "@/vue/router/index"

export function initializeVueApps() {
  const app = createApp(App)
  const pinia = createPinia()
  app.use(pinia)
  app.use(router)
  app.mount('#app')
}