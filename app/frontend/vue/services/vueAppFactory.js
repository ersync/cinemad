import {createApp} from 'vue'
import {sharedPinia} from '@/vue/stores/sharedPinia'
import {addToast} from '@/vue/services/toast'
import vEasyPieChart from '@/vue/directives/v-easy-pie-chart'

export function createVueApp(component, props = {}, options = {}) {
  const app = createApp(component, props)
  app.use(sharedPinia)
  addToast(app)

  if (options.globalDirectives) {
    options.globalDirectives.forEach((directive) => {
      app.directive(directive.name, directive.directive)
    })
  }

  return app
}
