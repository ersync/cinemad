import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { authApiService } from '@/services/authApiService'
import { ErrorTypes } from '@/services/fetch'
import router from '@/vue/router'

export const useAuthStore = defineStore('auth', () => {
  const user = ref(null)
  const loading = ref(false)
  const error = ref(null)
  const checkedAuth = ref(false)
  const sessionCheckInterval = ref(null)

  const isAuthenticated = computed(() => !!user.value)

  function startSessionChecker() {
    stopSessionChecker()

    sessionCheckInterval.value = setInterval(async () => {
      if (isAuthenticated.value) {
        console.log('Checking session validity...')
        const isStillValid = await checkAuth()

        if (!isStillValid) {
          console.log('Session expired, logging out...')
          await logout()
          router.push({
            name: 'login',
            query: { reason: 'session_expired' }
          })
        }
      }
    }, 5 * 60 * 1000)
  }

  function stopSessionChecker() {
    if (sessionCheckInterval.value) {
      clearInterval(sessionCheckInterval.value)
      sessionCheckInterval.value = null
    }
  }

  function setUser(userData) {
    user.value = userData
    checkedAuth.value = true
    startSessionChecker()
  }

  function resetState() {
    user.value = null
    error.value = null
    checkedAuth.value = false
    stopSessionChecker()
  }

  // Auth actions
  async function checkAuth() {
    loading.value = true
    error.value = null

    try {
      const response = await authApiService.getCurrentUser()
      if (response.success && response.user) {
        setUser(response.user)
        return true
      }
      resetState()
      return false
    } catch (err) {
      console.error('Auth check failed:', err)
      resetState()
      return false
    } finally {
      loading.value = false
    }
  }

  async function login(credentials) {
    loading.value = true;
    error.value = null;

    try {
      const response = await authApiService.login(credentials);

      if (response.success && response.user) {
        setUser(response.user);

        window.location.replace('/');
        return null;
      } else {

      }
      return response;
    } catch (err) {
      error.value = err.userMessage;
      throw err;
    } finally {
      loading.value = false;
    }
  }

  async function register(userData) {
    loading.value = true
    error.value = null

    try {
      const response = await authApiService.register(userData)
      if (response.success && response.user) {
        setUser(response.user)
      }
      return response
    } catch (err) {
      error.value = err.userMessage
      throw err
    } finally {
      loading.value = false
    }
  }

  async function logout() {
    loading.value = true
    error.value = null

    try {
      await authApiService.logout()
      resetState()
      setTimeout(() => {
        window.location.href = '/login'
      }, 100)
    } catch (err) {
      console.error('Logout error:', err)
      window.location.href = '/login'
    }
    loading.value = false
  }

  async function updateProfile(userData) {
    loading.value = true
    error.value = null

    try {
      const response = await authApiService.updateProfile(userData)
      if (response.success && response.user) {
        setUser(response.user)
      }
      return response
    } catch (err) {
      error.value = err.userMessage
      throw err
    } finally {
      loading.value = false
    }
  }

  async function updatePassword(userData) {
    loading.value = true
    error.value = null

    try {
      const response = await authApiService.updatePassword(userData)
      return response
    } catch (err) {
      error.value = err.userMessage
      throw err
    } finally {
      loading.value = false
    }
  }

  return {
    // State
    user,
    loading,
    error,
    checkedAuth,

    // Computed
    isAuthenticated,

    // Actions
    checkAuth,
    login,
    register,
    logout,
    updateProfile,
    updatePassword,
    resetState
  }
})