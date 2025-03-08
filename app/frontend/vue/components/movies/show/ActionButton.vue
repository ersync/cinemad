<template>
  <div class="h-full py-1 relative">
    <div
        @click.prevent="handleClick"
        class="peer flex justify-center items-center w-11 h-11
        rounded-full cursor-pointer transition-all duration-300
        bg-black border border-white/10 shadow-sm  hover:scale-105 active:scale-95"
        :class="[isActive ? activeClass : '']"
    >
      <svg class="h-4 w-4" :class="[isActive ? activeClass : '']">
        <use :xlink:href="iconHref"></use>
      </svg>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue'

const props = defineProps({
  label: {
    type: String,
    required: true,
  },
  isActive: {
    type: Boolean,
    required: false,
  },
  iconHref: {
    type: String,
    required: true,
  },
  activeClass: {
    type: String,
    required: true,
  },
  onClick: {
    type: Function,
    required: true,
  },
})

const handleClick = () => {
  props.onClick()
}
</script>
