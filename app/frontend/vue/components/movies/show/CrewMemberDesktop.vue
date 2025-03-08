<template>
  <li class="basis-1/2">
    <span>{{ crew.name }}</span>
    <span class="block text-[0.9em] font-SourceProNormal text-white/80">
      {{ formatRoles(crew.roles) }}
    </span>
  </li>
</template>

<script setup>
const props = defineProps({
  crew: {
    type: Object,
    required: true
  }
})

const formatRoles = (roles) => {
  return roles.join(', ')
}
</script>