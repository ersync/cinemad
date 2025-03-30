<script setup>
import { reactive } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/vue/stores/authStore'
import AuthLayout from '@/vue/components/auth/AuthLayout.vue'
import FormInput from '@/vue/components/auth/FormInput.vue'
import ErrorMessage from '@/vue/components/auth/ErrorMessage.vue'
import SocialLogin from '@/vue/components/auth/SocialLogin.vue'
import SubmitButton from '@/vue/components/auth/SubmitButton.vue'

const router = useRouter()
const route = useRoute()
const authStore = useAuthStore()

const formData = reactive({
  email: '',
  password: '',
  remember: false,
  showPassword: false,
  errors: null
})

async function handleSubmit() {
  try {
    formData.errors = null

    if (!formData.email || !formData.password) {
      formData.errors = {
        form: 'Please fill in all required fields.'
      }
      return
    }

    await authStore.login({
      email: formData.email,
      password: formData.password,
      remember: formData.remember
    })

    const redirectPath = route.query.redirect || '/'

    router.push(redirectPath)

  } catch (error) {
    formData.errors = {
      auth: error.message || 'Invalid email or password.'
    }
  }
}
</script>
<template>
  <AuthLayout>
    <template #left-header>
      <div class="mb-6 animate-fade-in">
        <div class="inline-block px-3 py-1 rounded-full bg-white/10 backdrop-blur-sm border border-white/20">
          <span class="text-xl font-semibold tracking-wide text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-violet-300">CinEmad</span>
        </div>
      </div>
      
      <h1 class="text-5xl font-bold leading-tight tracking-tight animate-fade-in">
        Welcome <br/>
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 via-blue-300 to-violet-300">
          Back
        </span>
      </h1>
      
      <p class="text-xl font-light text-gray-200 leading-relaxed animate-fade-in-delay max-w-md">
        Sign in to continue your cinematic journey and access your personalized movie experience.
      </p>
      <div class="pt-4 space-y-3 animate-fade-in-delay">
        <div class="flex items-center">
          <div class="h-1.5 w-1.5 rounded-full bg-cyan-300 mr-3"></div>
          <span class="text-gray-200">Continue with your watchlists and ratings</span>
        </div>
        <div class="flex items-center">
          <div class="h-1.5 w-1.5 rounded-full bg-cyan-300 mr-3"></div>
          <span class="text-gray-200">Get personalized recommendations</span>
        </div>
      </div>
    </template>
    
    <template #testimonial>
      <div></div>
    </template>
    
    <form @submit.prevent="handleSubmit" class="mt-4 space-y-5 animate-fade-in">
      <div class="text-center">
        <h2 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-gray-100">Sign in</h2>
        <p class="mt-2 text-xs sm:text-sm text-gray-600 dark:text-gray-400">
          Access your movie collection
        </p>
      </div>

      <FormInput
          v-model="formData.email"
          label="Email address"
          type="email"
          required
          placeholder="Enter your email"
          class="transform transition-all duration-200"
      />

      <FormInput
          v-model="formData.password"
          label="Password"
          :type="formData.showPassword ? 'text' : 'password'"
          required
          placeholder="Enter your password"
          class="transform transition-all duration-200"
      >
        <template #append>
          <button
              @click.prevent="formData.showPassword = !formData.showPassword"
              type="button"
              class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300 transition-colors duration-200"
          >
            <i class="fas" :class="formData.showPassword ? 'fa-eye-slash' : 'fa-eye'"></i>
          </button>
        </template>
      </FormInput>

      <div class="flex items-center justify-between text-sm">
        <label class="flex items-center text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-200 transition-colors duration-200">
          <input
              v-model="formData.remember"
              type="checkbox"
              class="w-4 h-4 rounded border-gray-300 dark:border-gray-600 text-[#032541] dark:text-indigo-500 focus:ring-[#032541] dark:focus:ring-indigo-500 transition-colors duration-200"
          />
          <span class="ml-2">Remember me</span>
        </label>
        <router-link
            to="/forgot-password"
            class="font-medium text-[#032541] dark:text-indigo-400 hover:text-[#202035] dark:hover:text-indigo-300 transition-all duration-200 hover:underline"
        >
          Forgot password?
        </router-link>
      </div>

      <ErrorMessage
          v-if="formData.errors || authStore.error"
          :errors="formData.errors || { auth: authStore.error }"
      />

      <SubmitButton
          :loading="authStore.loading"
          icon="fa-lock"
          text="Sign in"
          loading-text="Signing in..."
          class="w-full py-3 px-4 bg-gradient-to-r from-[#032541] to-[#202035] dark:from-indigo-800 dark:to-purple-900 text-white rounded-lg hover:from-[#032541]/90 hover:to-[#202035]/90 dark:hover:from-indigo-700 dark:hover:to-purple-800 transform transition-all duration-200 hover:shadow-lg"
      />

      <SocialLogin class="space-y-3" />

      <p class="text-sm sm:text-base text-center text-gray-600 dark:text-gray-400">
        Don't have an account?
        <router-link
            to="/register"
            class="font-medium text-[#032541] dark:text-indigo-400 hover:text-[#202035] dark:hover:text-indigo-300 transition-all duration-200 hover:underline"
        >
          Sign up for free
        </router-link>
      </p>
    </form>
  </AuthLayout>
</template>
<style scoped>
.animate-fade-in {
  animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>