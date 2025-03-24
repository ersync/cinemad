<template>
  <div>
    <GlobalLoader />
    <GlobalSearchOverlay />
    <MobileSearchHandler />

    <router-view v-slot="{ Component, route }">
      <keep-alive include="UserLayout">
        <component :is="Component" :key="getComponentKey(route)" />
      </keep-alive>
    </router-view>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'
import GlobalLoader from "@/vue/components/GlobalLoader.vue"
import GlobalSearchOverlay from "@/vue/components/GlobalSearchOverlay.vue"
import MobileSearchHandler from "@/vue/components/MobileSearchHandler.vue"

const route = useRoute()

const getComponentKey = (route) => {
  if (route.path.startsWith('/users/')) {
    return `user-${route.params.username}`
  }
  return route.fullPath
}

</script>