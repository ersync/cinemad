<script setup>
const props = defineProps({
  crew: {
    type: Object,
    required: true,
    validator: (value) => {
      return value.hasOwnProperty('name') && value.hasOwnProperty('roles')
    }
  }
})

const formatRoles = (roles) => {
  return roles.join(', ')
}
</script>

<template>
  <li class="flex flex-col p-4 backdrop-blur-sm bg-white/5 rounded-lg
             transform transition-all duration-300 hover:bg-white/10
             border border-white/10">
    <span class="text-base font-medium mb-1">{{ crew.name }}</span>
    <span class="text-sm text-white/70">
      {{ formatRoles(crew.roles) }}
    </span>
  </li>
</template>