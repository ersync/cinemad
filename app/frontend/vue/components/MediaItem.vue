<template>
  <div class="relative bg-black inline-block h-full">
    <div v-if="media.isVideo">
      <template v-if="!isIframe">
        <div
            @click="$emit('turn-to-iframe')"
            class="flex justify-center items-center bg-black/70 absolute w-16 h-16 rounded-full inset-0 my-auto mx-auto text-white"
        >
          <svg class="w-8 h-8">
            <use xlink:href="#play"></use>
          </svg>
        </div>
        <img
            :src="`https://i.ytimg.com/vi/${media.url}/hqdefault.jpg`"
            alt="Thumbnail"
            class="w-[533px] h-[240px] md:h-[300px] object-cover"
        >
      </template>
      <iframe
          v-else
          width="533"
          height="240"
          :src="`https://www.youtube.com/embed/${media.url}`"
          frameborder="0"
          allowfullscreen
          class="w-[533px] h-[240px] md:h-[300px] object-cover"
      ></iframe>
    </div>
    <img
        v-else
        :src="media.url"
        alt=""
        class="h-[300px]"
    >
  </div>
</template>

<script setup>
const props = defineProps({
  media: Object,
  isIframe: Boolean,
})

defineEmits(['turn-to-iframe'])
</script>