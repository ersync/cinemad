import { createRouter, createWebHistory } from 'vue-router'
import { useLoadingStore } from '@/vue/stores/loadingStore'
import { useAuthStore } from '@/vue/stores/authStore'

const router = createRouter({
  history: createWebHistory(),
  routes: [
  {
    path: '/login',
    name: 'login',
    component: () => import('@/vue/pages/auth/LoginPage.vue'),
    meta: {
    requiresGuest: true,
    title: 'Login - Cinemad'
    }
  },
  {
    path: '/register',
    name: 'register',
    component: () => import('@/vue/pages/auth/SignupPage.vue'),
    meta: {
    requiresGuest: true,
    title: 'Register - Cinemad'
    }
  },
  {
    path: '/',
    name: 'home',
    component: () => import('@/vue/pages/HomePage.vue'),
    meta: {
    title: 'Cinemad - Your Movie Database'
    }
  },
  {
    path: '/discovery',
    name: 'discovery',
    component: () => import('@/vue/pages/MovieDiscoveryPage.vue'),
    meta: {
    title: 'Discover Movies - Cinemad'
    }
  },
  {
    path: '/movies/:slug',
    name: 'movie-show',
    component: () => import('@/vue/pages/MovieShow.vue'),
    props: true,
    meta: {
    dynamicTitle: true
    }
  },
  {
    path: '/users/:username',
    component: () => import('@/vue/components/user/UserLayout.vue'),
    meta: { requiresAuth: true, keepAlive: true },
    props: true,
    children: [
    {
      path: '',
      name: 'userProfile',
      component: () => import('@/vue/pages/user/TheProfile.vue'),
      meta: {
      title: route => `${route.params.username}'s Profile - Cinemad`
      }
    },
    {
      path: 'ratings',
      name: 'userRatings',
      component: () => import('@/vue/pages/user/UserRating.vue'),
      meta: {
      title: route => `${route.params.username}'s Ratings - Cinemad`
      }
    },
    {
      path: 'watchlist',
      name: 'userWatchlist',
      component: () => import('@/vue/pages/user/UserWatchlist.vue'),
      meta: {
      title: route => `${route.params.username}'s Watchlist - Cinemad`
      }
    },
    {
      path: 'favorites',
      name: 'userFavorites',
      component: () => import('@/vue/pages/user/UserFavorites.vue'),
      meta: {
      title: route => `${route.params.username}'s Favorites - Cinemad`
      }
    },
    {
      path: 'edit',
      name: 'editProfile',
      component: () => import('@/vue/pages/user/EditProfile.vue'),
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