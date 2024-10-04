<template>
  <li class="h-full py-3">
    <div @click.prevent="handleClick"
         class="flex justify-center items-center w-9 h-9 md:w-[46px] md:h-[46px] bg-white/10 border border-white/5 rounded-full cursor-pointer">
      <svg class="h-4 w-4" :class="{ [activeClass]: isActive }">
        <use :xlink:href="iconHref"></use>
      </svg>
    </div>
  </li>
</template>

<script setup>
import {defineProps} from 'vue'

const props = defineProps({
  isActive: {
    type: Boolean,
    required: true,
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