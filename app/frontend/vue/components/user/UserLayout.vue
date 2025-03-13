<template>
  <div class="mb-32 font-SourceProNormal antialiased">
    <div v-if="error" class="max-w-7xl mx-auto px-4 py-8 text-center">
      <p class="text-red-600">{{ error }}</p>
    </div>

    <div v-else-if="isLoading">
      <UserLayoutSkeleton />
    </div>

    <div v-else-if="interactionStore.userProfileComputed" class="relative">
      <ProfileHeader :user="interactionStore.userProfileComputed" />
      <ShortcutBar :username="interactionStore.userProfileComputed.username" />

      <router-view v-slot="{ Component, route }">
        <transition
            name="fade-slide"
            mode="out-in"
        >
          <component :is="Component" :key="route.name" />
        </transition>
      </router-view>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, defineComponent } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useUserInteractionStore } from '@/vue/stores/userInteractionStore'
import ProfileHeader from './ProfileHeader.vue'
import ShortcutBar from './ShortcutBar.vue'
import UserLayoutSkeleton from "@/vue/components/user/UserLayoutSkeleton.vue"

defineComponent({
  name: 'UserLayout'
})

const route = useRoute()
const router = useRouter()
const interactionStore = useUserInteractionStore()

const error = ref(null)
const isLoading = ref(true)

const fetchUserData = async () => {
  isLoading.value = true
  error.value = null

  try {
    const username = route.params.username
    if (!username) throw new Error('Username is required')

    const profileResponse = await interactionStore.fetchUserProfile(username)

    if (profileResponse.success) {
      await Promise.all([
        interactionStore.fetchUserList('watchlist', 1, username),
        interactionStore.fetchUserList('favorites', 1, username),
        interactionStore.fetchUserList('ratings', 1, username)
      ])
    } else {
      throw new Error('Failed to load user profile')
    }
  } catch (err) {
    console.error('Error fetching user data:', err)
    error.value = err.message
  } finally {
    isLoading.value = false
  }
}

watch(
    () => route.params.username,
    (newUsername) => {
      if (newUsername) {
        fetchUserData()
      }
    }
)

onMounted(() => {
  fetchUserData()
})
</script>


<style scoped>
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.3s ease;
}

.fade-slide-enter-from {
  opacity: 0;
  transform: translateX(20px);
}

.fade-slide-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}
</style>