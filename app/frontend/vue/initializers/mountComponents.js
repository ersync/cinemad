import {sharedPinia} from '@/vue/stores/sharedPinia'
import {useMovieStore} from '@/vue/stores/movieStore'
import {createVueApp} from '@/vue/services/vueAppFactory'
import MovieMedia from '@/vue/components/MovieMedia.vue'
import MobileMenu from '@/vue/components/MobileMenu.vue'
import UserMenu from '@/vue/components/UserMenu.vue'
import MovieActionsPanel from '@/vue/components/MovieActionsPanel.vue'
import MobileActionsPanel from '@/vue/components/MovieMobileActionsPanel.vue'
import vEasyPieChart from '@/vue/directives/v-easy-pie-chart.js'

export function mountComponents() {

  const movieStore = useMovieStore(sharedPinia)


  const movieMediaEl = document.getElementById('movie-media')
  if (movieMediaEl) {
    createVueApp(MovieMedia).mount('#movie-media')
  }

  const mobileMenuEl = document.getElementById('mobile-menu-container')
  if (mobileMenuEl) {
    createVueApp(MobileMenu).mount('#mobile-menu-container')
  }

  const userMenuEl = document.getElementById('user-menu')
  if (userMenuEl) {
    createVueApp(UserMenu).mount('#user-menu')
  }

  const actionsPanelEl = document.getElementById('actions-panel')
  if (actionsPanelEl) {
    const movieId = actionsPanelEl.dataset.movieId
    const app = createVueApp(MovieActionsPanel, {movieId}, {
      globalDirectives: [{name: 'easy-pie-chart', directive: vEasyPieChart}]
    })
    app.mount('#actions-panel')
  }
  const mobileActionsPanelEl = document.getElementById('mobile-actions-panel')
  if (mobileActionsPanelEl) {
    const movieId = mobileActionsPanelEl.dataset.movieId
    const app = createVueApp(MobileActionsPanel, {movieId}, {
      globalDirectives: [{name: 'easy-pie-chart', directive: vEasyPieChart}]
    })
    app.mount('#mobile-actions-panel')
  }
}