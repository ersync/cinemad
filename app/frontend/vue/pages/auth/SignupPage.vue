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
  username: '',
  email: '',
  password: '',
  passwordConfirmation: '',
  showPassword: false,
  acceptTerms: false,
  errors: {}
})

async function validateForm() {
  const errors = {}

  if (formData.username.length < 6) {
    errors.username = 'Username must be at least 6 characters'
  }

  if (formData.password !== formData.passwordConfirmation) {
    errors.password = 'Passwords do not match'
  }

  if (!formData.acceptTerms) {
    errors.terms = 'You must accept the Terms of Service and Privacy Policy'
  }

  return errors
}

async function handleSubmit() {
  try {
    formData.errors = {}

    const validationErrors = await validateForm()
    if (Object.keys(validationErrors).length > 0) {
      formData.errors = validationErrors
      return
    }

    await authStore.register({
      username: formData.username,
      email: formData.email,
      password: formData.password,
      password_confirmation: formData.passwordConfirmation,
      terms: formData.acceptTerms
    })

    const redirectPath = route.query.redirect || '/'
    router.push(redirectPath)

  } catch (error) {
    if (error.response?.data?.errors) {
      formData.errors = Object.entries(error.response.data.errors).reduce((acc, [field, messages]) => {
        const fieldName = field.charAt(0).toUpperCase() + field.slice(1).replace('_', ' ')
        const message = Array.isArray(messages) ? messages[0] : messages
        acc[field] = `${fieldName} ${message}`
        return acc
      }, {})
    } else {
      formData.errors = {
        general: error.message || 'Registration failed. Please try again.'
      }
    }
  }
}
</script>

<template>
  <AuthLayout>
    <!-- Left header section -->
    <template #left-header>
      <h1 class="text-5xl font-bold leading-tight animate-fade-in">
        Join CinEmad <br/>
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-200 to-sky-200">
          Community
        </span>
      </h1>
      <p class="text-lg text-gray-200 leading-relaxed animate-fade-in-delay">
        Create your account to unlock all features. Rate movies, create watchlists, and join discussions.
      </p>
    </template>

    <form @submit.prevent="handleSubmit" class="mt-4 space-y-5 sm:mt-3 sm:space-y-5 animate-fade-in">
      <div class="text-center">
        <h2 class="text-2xl sm:text-3xl font-bold text-gray-900">Create Account</h2>
        <p class="mt-2 text-xs sm:text-sm text-gray-600">
          Join our community of movie enthusiasts
        </p>
      </div>

      <!-- Form inputs -->
      <FormInput
          v-model="formData.username"
          label="Username"
          type="text"
          required
          placeholder="Choose a username"
          class="transform transition-all duration-200"
      />

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
          placeholder="Create a password"
          :showStrength="true"
          class="transform transition-all duration-200"
      >
        <template #append>
          <button
              @click.prevent="formData.showPassword = !formData.showPassword"
              type="button"
              class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600 transition-colors duration-200"
          >
            <i class="fas" :class="formData.showPassword ? 'fa-eye-slash' : 'fa-eye'"></i>
          </button>
        </template>
      </FormInput>

      <FormInput
          v-model="formData.passwordConfirmation"
          label="Confirm Password"
          :type="formData.showPassword ? 'text' : 'password'"
          required
          placeholder="Confirm your password"
          class="transform transition-all duration-200"
      />

      <!-- Terms acceptance -->
      <div class="flex items-start">
        <div class="flex items-center h-5">
          <input
              v-model="formData.acceptTerms"
              id="terms"
              type="checkbox"
              required
              class="w-4 h-4 rounded border-gray-300 text-[#032541] focus:ring-[#032541] transition-colors duration-200"
          />
        </div>
        <div class="ml-3 text-xs sm:text-sm mt-0.5">
          <label for="terms" class="text-gray-600">
            I agree to the
            <a href="/terms" class="text-[#032541] hover:text-[#202035] hover:underline">Terms of Service</a>
            and
            <a href="/privacy" class="text-[#032541] hover:text-[#202035] hover:underline">Privacy Policy</a>
          </label>
        </div>
      </div>

      <ErrorMessage
          v-if="Object.keys(formData.errors).length > 0 || authStore.error"
          :errors="formData.errors || { auth: authStore.error }"
      />

      <SubmitButton
          :loading="authStore.loading"
          icon="fa-user-plus"
          text="Create Account"
          loading-text="Creating account..."
          class="w-full py-3 px-4 bg-gradient-to-r from-[#032541] to-[#202035] text-white rounded-lg hover:from-[#032541]/90 hover:to-[#202035]/90 transform transition-all duration-200 hover:shadow-lg"
      />

      <SocialLogin class="space-y-3" />

      <p class="text-sm sm:text-base text-center text-gray-600">
        Already have an account?
        <router-link
            to="/login"
            class="font-medium text-[#032541] hover:text-[#202035] transition-all duration-200 hover:underline"
        >
          Sign in
        </router-link>
      </p>
    </form>
  </AuthLayout>
</template>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.3s ease-out;
}

.animate-fade-in-delay {
  animation: fadeIn 0.3s ease-out 0.2s both;
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