import {createApp} from 'vue'
import {createPinia} from 'pinia'
import {addToast} from '@/vue/services/toast'
import vEasyPieChart from '@/vue/directives/v-easy-pie-chart'

export function createVueApp(component, props = {}, options = {}) {
  const app = createApp(component, props)
  const pinia = createPinia()
  app.use(pinia)
  addToast(app)

  if (options.globalDirectives) {
    options.globalDirectives.forEach((directive) => {
      app.directive(directive.name, directive.directive)
    })
  }

  return app
}
