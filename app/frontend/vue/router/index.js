import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '@/vue/pages/HomePage.vue'
import MovieShow from '@/vue/pages/MovieShow.vue'
import MovieDiscoveryPage from '@/vue/pages/MovieDiscoveryPage.vue'
import UserLayout from '@/vue/components/user/UserLayout.vue'
import TheProfile from '@/vue/pages/user/TheProfile.vue'
import UserRating from '@/vue/pages/user/UserRating.vue'
import UserWatchlist from '@/vue/pages/user/UserWatchlist.vue'
import UserFavorites from '@/vue/pages/user/UserFavorites.vue'
import EditProfile from '@/vue/pages/user/EditProfile.vue'
import LoginPage from '@/vue/pages/auth/LoginPage.vue'
import SignupPage from "@/vue/pages/auth/SignupPage.vue"
import { useLoadingStore } from '@/vue/stores/loadingStore'
import { useAuthStore } from '@/vue/stores/authStore'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/login',
      name: 'login',
      component: LoginPage,
      meta: {
        requiresGuest: true,
        title: 'Login - Cinemad'
      }
    },
    {
      path: '/register',
      name: 'register',
      component: SignupPage,
      meta: {
        requiresGuest: true,
        title: 'Register - Cinemad'
      }
    },
    {
      path: '/',
      name: 'home',
      component: HomePage,
      meta: {
        title: 'Cinemad - Your Movie Database'
      }
    },
    {
      path: '/discovery',
      name: 'discovery',
      component: MovieDiscoveryPage,
      meta: {
        title: 'Discover Movies - Cinemad'
      }
    },
    {
      path: '/movies/:slug',
      name: 'movie-show',
      component: MovieShow,
      props: true,
      meta: {
        dynamicTitle: true
      }
    },
    {
      path: '/users/:username',
      component: UserLayout,
      meta: { requiresAuth: true, keepAlive: true },
      props: true,
      children: [
        {
          path: '',
          name: 'userProfile',
          component: TheProfile,
          meta: {
            title: route => `${route.params.username}'s Profile - Cinemad`
          }
        },
        {
          path: 'ratings',
          name: 'userRatings',
          component: UserRating,
          meta: {
            title: route => `${route.params.username}'s Ratings - Cinemad`
          }
        },
        {
          path: 'watchlist',
          name: 'userWatchlist',
          component: UserWatchlist,
          meta: {
            title: route => `${route.params.username}'s Watchlist - Cinemad`
          }
        },
        {
          path: 'favorites',
          name: 'userFavorites',
          component: UserFavorites,
          meta: {
            title: route => `${route.params.username}'s Favorites - Cinemad`
          }
        },
        {
          path: 'edit',
          name: 'editProfile',
          component: EditProfile,
          meta: {
            title: 'Edit Profile - Cinemad'
          }
        }
      ]
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'notFound',
      component: () => import('@/vue/pages/NotFound.vue'),
      meta: {
        title: '404 Not Found - Cinemad'
      }
    }
  ]
})

router.beforeEach(async (to, from, next) => {
  const loadingStore = useLoadingStore()
  const authStore = useAuthStore()

  loadingStore.startLoading()

  if (!authStore.checkedAuth) {
    try {
      await authStore.checkAuth()
    } catch (error) {
      console.error('Auth check failed:', error)
    }
  }

  if (to.meta.requiresGuest && authStore.isAuthenticated) {
    next({
      name: 'userProfile',
      params: { username: authStore.user.username }
    })
    return
  }

  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    next({
      name: 'login',
      query: { redirect: to.fullPath }
    })
    return
  }

  next()
})

router.afterEach((to) => {
  const loadingStore = useLoadingStore()
  loadingStore.stopLoading()

  if (to.meta.dynamicTitle) {
    return
  }

  if (typeof to.meta.title === 'function') {
    document.title = to.meta.title(to)
    return
  }

  if (to.meta.title) {
    document.title = to.meta.title
  } else {
    document.title = 'Cinemad'
  }
})

export default router