import {createVueApp} from '@/vue/services/vueAppFactory'
import MediaWidget from '@/vue/components/MovieMedia.vue'
import MobileMovieRatingPanel from '@/vue/components/MobileMovieRatingPanel.vue'
import MobileMenu from '@/vue/components/MobileMenu.vue'
import UserMenu from '@/vue/components/UserMenu.vue'
import MovieActionsPanel from '@/vue/components/MovieActionsPanel.vue'
import vEasyPieChart from '@/vue/directives/v-easy-pie-chart.js'

export function mountComponents() {
  const mediaWidgetEl = document.getElementById('media-widget')
  if (mediaWidgetEl) {
    createVueApp(MediaWidget).mount('#media-widget')
  }

  const mobileMenuEl = document.getElementById('mobile-menu-container')
  if (mobileMenuEl) {
    createVueApp(MobileMenu).mount('#mobile-menu-container')
  }

  const userMenuEl = document.getElementById('user-menu')
  if (userMenuEl) {
    createVueApp(UserMenu).mount('#user-menu')
  }

  const ratingWidgetEl = document.getElementById('actions-panel')
  if (ratingWidgetEl) {
    const movieId = ratingWidgetEl.dataset.movieId
    const app = createVueApp(MovieActionsPanel, {movieId}, {
      globalDirectives: [{name: 'easy-pie-chart', directive: vEasyPieChart}]
    })
    app.mount('#actions-panel')
  }
  const mobileScoreEl = document.getElementById('mobile-movie-rating-panel')
  if (mobileScoreEl) {
    const movieId = ratingWidgetEl.dataset.movieId
    const app = createVueApp(MobileMovieRatingPanel, {movieId}, {
      globalDirectives: [{name: 'easy-pie-chart', directive: vEasyPieChart}]
    })
    app.mount('#mobile-movie-rating-panel')
  }
}