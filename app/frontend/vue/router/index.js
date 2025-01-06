import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '@/vue/pages/HomePage.vue'
import MovieShow from '@/vue/pages/MovieShow.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomePage
    },
    {
      path: '/movies/:id',
      name: 'movie-show',
      component: MovieShow,
      props: true
    }
  ]
})

export default router