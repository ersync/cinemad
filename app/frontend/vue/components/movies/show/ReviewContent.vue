<template>
  <div class="pt-5 child:mb-4 last-child-p:inline">
    <p>{{ content }}</p>
    <a href="#" class="underline" @click.prevent="$emit('readMore')">
      Read the rest
    </a>
  </div>
</template>

<script setup>
defineProps({
  content: {
    type: String,
    required: true
  }
})

defineEmits(['readMore'])
</script>