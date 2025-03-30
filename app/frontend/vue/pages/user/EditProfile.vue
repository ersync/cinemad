<template>
  <div v-if="userProfile" class="edit-profile min-h-screen bg-gray-50 dark:bg-gray-900">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div class="max-w-3xl mx-auto space-y-8">
        <!-- Page Title -->
        <div class="flex items-center justify-between">
          <h1 class="text-2xl font-bold text-gray-900 dark:text-gray-100">Edit Profile</h1>
        </div>

        <form @submit.prevent="saveProfile" class="space-y-6">
          <!-- Profile Picture Section -->
          <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-6">Profile Picture</h3>
            <div class="flex items-center gap-8">
              <div class="relative group">
                <div v-if="!userProfile.avatar_url"
                     class="w-32 h-32 rounded-full bg-gradient-to-r from-blue-500 to-blue-600 dark:from-indigo-600 dark:to-purple-800 flex items-center justify-center">
                  <span class="text-3xl font-bold text-white">{{ userInitial }}</span>
                </div>
                <img v-else
                     :src="userProfile.avatar_url"
                     class="w-32 h-32 rounded-full object-cover ring-4 ring-white dark:ring-gray-700"
                     alt="Profile avatar">
                <div class="absolute inset-0 rounded-full bg-black bg-opacity-40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                </div>
              </div>

              <div class="flex flex-col items-center gap-3">
                <input type="file"
                       class="hidden"
                       ref="fileInput"
                       accept="image/*"
                       @change="handleAvatarChange">
                <button type="button"
                        @click="$refs.fileInput.click()"
                        class="text-sm sm:text-base px-4 py-2 bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-lg hover:bg-blue-100 dark:hover:bg-blue-800/40 transition-colors">
                  Upload New Picture
                </button>
                <button v-if="userProfile.avatar_url"
                        type="button"
                        @click="removeAvatar"
                        class="block text-sm text-red-600 dark:text-red-400 hover:text-red-700 dark:hover:text-red-300">
                  Remove Picture
                </button>
              </div>
            </div>
          </div>

          <!-- Basic Information Section -->
          <div class="bg-white dark:bg-gray-800 rounded-xl p-6 shadow-sm dark:shadow-gray-900/20">
            <h3 class="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-6">Basic Information</h3>
            <div class="space-y-6">
              <div>
                <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Username
                </label>
                <input id="username"
                       v-model="formData.username"
                       type="text"
                       class="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-700 dark:bg-gray-700 dark:text-white focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent">
              </div>

              <div>
                <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Email Address
                </label>
                <input id="email"
                       v-model="formData.email"
                       type="email"
                       disabled
                       class="w-full px-4 py-2 rounded-lg border border-gray-300 dark:border-gray-700 bg-gray-50 dark:bg-gray-600 dark:text-gray-300">
              </div>
            </div>
          </div>

          <!-- Save Button -->
          <div class="flex justify-end">
            <button type="submit"
                    :disabled="saving"
                    class="save-button">
              <span v-if="saving" class="flex items-center gap-2">
                <svg class="animate-spin h-5 w-5" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" fill="none"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Saving...
              </span>
              <span v-else>Save Changes</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useToast } from 'vue-toastification'
import { userApiService } from '@/services/userApiService'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'

const router = useRouter()
const toast = useToast()
const interactionStore = useUserInteractionStore()
const saving = ref(false)
const fileInput = ref(null)

const formData = ref({
  username: '',
  email: ''
})

const userProfile = computed(() => interactionStore.userProfileComputed)

watch(userProfile, (newUser) => {
  if (newUser) {
    formData.value = {
      username: newUser.username || '',
      email: newUser.email || ''
    }
  }
}, { immediate: true })

const userInitial = computed(() => {
  return formData.value.username ? formData.value.username[0].toUpperCase() : ''
})

const handleAvatarChange = async (event) => {
  const file = event.target.files[0]
  if (!file) return

  try {
    const response = await userApiService.uploadAvatar(formData.value.username, file)
    if (response.success) {
      toast.success('Profile picture updated successfully')
      // Refresh the user profile in the store
      await interactionStore.fetchUserProfile(formData.value.username)
    } else {
      throw new Error(response.error || 'Failed to upload profile picture')
    }
  } catch (error) {
    console.error('Error uploading avatar:', error)
    toast.error(error.message || 'Failed to upload profile picture')
  }
}

const removeAvatar = async () => {
  try {
    const response = await userApiService.removeAvatar(formData.value.username)
    if (response.success) {
      toast.success('Profile picture removed successfully')
      // Refresh the user profile in the store
      await interactionStore.fetchUserProfile(formData.value.username)
    } else {
      throw new Error(response.error || 'Failed to remove profile picture')
    }
  } catch (error) {
    console.error('Error removing avatar:', error)
    toast.error(error.message || 'Failed to remove profile picture')
  }
}

const saveProfile = async () => {
  saving.value = true
  try {
    const response = await userApiService.updateCurrentUser(
        userProfile.value.username,
        formData.value
    )

    if (response.success) {
      toast.success('Profile updated successfully')
      // Refresh the user profile in the store and redirect
      await interactionStore.fetchUserProfile(response.user.username)
      window.location.href = `/users/${response.user.username}`
    } else {
      throw new Error(response.error || 'Failed to update profile')
    }
  } catch (error) {
    console.error('Error updating profile:', error)
    const errorMessage = error.data?.errors?.[0] || error.message || 'Failed to update profile'
    toast.error(errorMessage)
  } finally {
    saving.value = false
  }
}
</script>

<style scoped>
.save-button {
  @apply px-6 py-2.5 bg-blue-600 dark:bg-blue-700 text-white rounded-lg
  hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors duration-200
  disabled:opacity-50 disabled:cursor-not-allowed
  font-medium text-sm flex items-center justify-center
  min-w-[120px];
}
</style>