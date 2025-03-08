<template>
  <nav class="bg-white shadow-sm sm:px-6 py-3">
    <div class="max-w-6xl mx-auto">
      <ul class="flex items-center justify-center space-x-1 sm:space-x-4">
        <!-- Overview Section -->
        <li class="relative">
          <div class="group">
            <!-- Main Button -->
            <button
                class="flex items-center px-2 py-1.5 sm:px-5 sm:py-3 rounded-lg transition-all duration-200 font-medium text-base"
                :class="[
                isOverviewActive
                  ? 'bg-blue-50 text-tmdbLighterBlue'
                  : 'text-gray-700 hover:text-gray-900 hover:bg-gray-50'
              ]"
            >
              <svg
                  class="w-3 h-3 mr-1 sm:w-5 sm:h-5 sm:mr-2"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
              >
                <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                />
              </svg>
              <span class="text-sm sm:text-base">Overview</span>
              <svg class="w-3 h-3 ml-1 sm:w-5 sm:h-5 sm:ml-1.5 transition-transform duration-200 group-hover:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </button>

            <!-- Dropdown Menu -->
            <div class="absolute left-0 top-full w-56 rounded-xl shadow-[0_4px_20px_rgba(0,0,0,0.15)] bg-white ring-1 ring-black ring-opacity-5 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 z-50">
              <div class="py-2">
                <RouterLink
                    :to="{ name: 'userProfile', params: { username: username }}"
                    class="block px-5 py-3 text-[15px] text-gray-700 hover:bg-gray-50 hover:text-tmdbLighterBlue transition-colors duration-200"
                >
                  <div class="flex items-center text-sm sm:text-base">
                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                    Main Profile
                  </div>
                </RouterLink>

                <RouterLink
                    :to="{ name: 'editProfile', params: { username: username }}"
                    class="block px-5 py-3 text-[15px] text-gray-700 hover:bg-gray-50 hover:text-tmdbLighterBlue transition-colors duration-200"
                >
                  <div class="flex items-center text-sm sm:text-base">
                    <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                    </svg>
                    Edit Profile
                  </div>
                </RouterLink>
              </div>
            </div>
          </div>
        </li>

        <!-- Navigation Items -->
        <template v-for="item in navigationItems" :key="item.name">
          <li class="relative">
            <RouterLink
                :to="{ name: item.route, params: { username: username }}"
                class="block px-0 py-1 sm:px-5 sm:py-3 rounded-lg transition-all duration-200"
                v-slot="{ isActive }"
            >
              <div
                  class="flex items-center px-2 py-1.5 sm:p-2 rounded-md font-medium text-base"
                  :class="[
                  isActive
                    ? 'bg-blue-50 text-tmdbLighterBlue'
                    : 'text-gray-700 hover:text-gray-900 hover:bg-gray-50'
                ]"
              >
                <svg
                    class="w-3 h-3 mr-1 sm:w-5 sm:h-5 sm:mr-2"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                >
                  <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      :d="getIconPath(item.name)"
                  />
                </svg>
                <span class="text-sm sm:text-base">{{ item.name }}</span>
              </div>
            </RouterLink>
          </li>
        </template>
      </ul>
    </div>
  </nav>
</template>

<script setup>
import { computed } from 'vue'
import { RouterLink, useRoute } from 'vue-router'

const props = defineProps({
  username: {
    type: String,
    required: true,
    default: ''
  }
})

const route = useRoute()

const isOverviewActive = computed(() => {
  return route.name === 'userProfile'
})

const navigationItems = [
  {
    name: 'Ratings',
    route: 'userRatings',
  },
  {
    name: 'Watchlist',
    route: 'userWatchlist',
  },
  {
    name: 'Favorites',
    route: 'userFavorites',
  }
]

const getIconPath = (itemName) => {
  const icons = {
    Ratings: 'M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z',
    Watchlist: 'M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z',
    Favorites: 'M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z'
  }
  return icons[itemName]
}
</script>