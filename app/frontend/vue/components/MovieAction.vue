<template>
  <div class="h-full py-3 relative">
    <div @click.prevent="handleClick"
         class="peer flex justify-center items-center w-11 h-11 md:w-[46px] md:h-[46px] bg-white/10 border border-white/5 rounded-full cursor-pointer">
      <svg class="h-4 w-4" :class="{ [activeClass]: isActive }">
        <use :xlink:href="iconHref"></use>
      </svg>
    </div>
    <div
        class="absolute top-full left-1/2 -translate-x-1/2 mt-2 px-3 py-1 rounded bg-tmdbDarkBlue text-white text-base
            opacity-0 invisible peer-hover:opacity-100 peer-hover:visible transition-all duration-100 delay-150 whitespace-nowrap">
      {{ label === 'watchlist' ? 'Add to your watchlist' : label === 'favorite' ? 'Mark as favorite' : '' }}
    </div>
  </div>
</template>


<script setup>
import {defineProps} from 'vue'

const props = defineProps({
  label: {
    type: String,
    required: true,
  },
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