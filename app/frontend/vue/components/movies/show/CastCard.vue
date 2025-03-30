<script setup>
import { ref, computed, onMounted } from "vue"

const props = defineProps({
  person: {
    type: Object,
    required: true,
    validator: (obj) => {
      return ['id', 'name', 'image_url', 'character_names'].every(prop => prop in obj)
    }
  }
})

const emit = defineEmits(['image-loaded'])
const imageLoaded = ref(false)

const formattedName = computed(() => {
  const names = props.person.name.split(' ')
  const firstName = names[0]
  const lastName = names.slice(1).join(' ')
  return { firstName, lastName }
})

const formattedCharacterNames = computed(() => {
  const chars = props.person.character_names || []
  return chars.length ? chars.join(', ') : 'Unknown'
})

const handleImageLoad = () => {
  imageLoaded.value = true
  emit('image-loaded')
}

const handleImageError = () => {
  imageLoaded.value = true
  emit('image-loaded')
}

onMounted(() => {
  const img = new Image()
  img.onload = handleImageLoad
  img.onerror = handleImageError
  img.src = props.person.image_url
})
</script>

<template>
  <li class="group relative cursor-grab">
    <div class="h-full w-[100px] sm:w-[140px] overflow-hidden rounded-lg transition-all duration-300
                bg-white/80 backdrop-blur-sm dark:bg-gray-800/90 
                border border-gray-200/90 dark:border-gray-700/80
                shadow-[2px_8px_20px_rgb(0,0,0,0.02)] dark:shadow-[2px_8px_20px_rgb(0,0,0,0.1)]
                hover:shadow-[0_8px_30px_rgb(0,0,0,0.08)] dark:hover:shadow-[0_8px_30px_rgb(0,0,0,0.15)]">
      <!-- Image Container -->
      <div class="relative overflow-hidden h-[147px] sm:h-[207px]">
        <img
            :src="person.image_url"
            :alt="person.name"
            class="w-full h-full object-cover transition-all duration-300
                 group-hover:scale-[1.02] brightness-[0.98] dark:brightness-90"
            @load="handleImageLoad"
            @error="handleImageError"
        >
        <div class="absolute inset-x-0 top-0 h-[60%] bg-gradient-to-b from-white/10 to-transparent 
                    dark:from-gray-900/20"></div>
      </div>

      <!-- Content Container -->
      <div class="relative p-2.5 transition-all duration-300 
                  bg-gradient-to-b from-transparent to-white/40 dark:to-gray-900/30">
        <div class="space-y-0.5">
          <div class="text-[0.7rem] sm:text-[0.95rem] font-semibold min-h-[30px] sm:min-h-[42px]">
            <span class="block text-gray-800 dark:text-gray-100">{{ formattedName.firstName }}</span>
            <span class="block text-gray-800 dark:text-gray-100 -mt-1">
              {{ formattedName.lastName }}
            </span>
          </div>
          <h5 class="text-[0.7rem] sm:text-[0.9rem] text-gray-600 dark:text-gray-400 leading-snug line-clamp-1
                     font-medium opacity-85 dark:opacity-90">
            {{ formattedCharacterNames }}
          </h5>
        </div>
      </div>

      <div class="absolute inset-0 rounded-lg border border-black/5 dark:border-white/10 pointer-events-none"></div>

      <div class="absolute inset-0 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity duration-300
                  bg-gradient-to-t from-white/[0.042] to-transparent 
                  dark:from-gray-900/[0.042] pointer-events-none"></div>
    </div>
  </li>
</template>