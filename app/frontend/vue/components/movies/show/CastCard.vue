<template>
  <li class="min-h-full">
    <div class="h-full w-[122px] sm:w-[140px] overflow-hidden rounded-lg border border-tmdbLightGray pb-2.5 shadow-light">
      <div class="h-[175px] overflow-hidden">
        <img
            :src="person.image"
            :alt="person.name"
            class="cast-image"
        >
      </div>
      <div class="mt-2.5 mx-2.5 text-left">
        <span class="text-[0.95rem] block font-SourceProBold leading-5 mb-1">
          {{ person.name }}
        </span>
        <h5 class="text-[0.85rem] leading-4">
          {{ person.character_name }}
        </h5>
      </div>
    </div>
  </li>
</template>

<script setup>
defineProps({
  person: {
    type: Object,
    required: true,
    validator: (obj) => {
      return ['id', 'name', 'image', 'character_name'].every(prop => prop in obj)
    }
  }
})


</script>