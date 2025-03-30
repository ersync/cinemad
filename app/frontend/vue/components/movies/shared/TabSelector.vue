<template>
  <div class="inline-flex p-1 rounded-2xl 
              bg-white/90 dark:bg-gray-800/90 backdrop-blur-md
              relative overflow-hidden">
    <button
        v-for="option in options"
        :key="getOptionValue(option)"
        :class="[
          'relative py-1.5 px-2.5 sm:py-2 sm:px-4 rounded-xl text-xs sm:text-[14px] font-medium',
          'transition-colors duration-200',
          'overflow-hidden mx-0.5 cursor-pointer border-none bg-transparent outline-none',
          'group',
          isSelected(option)
            ? 'text-indigo-600 dark:text-indigo-400 font-semibold'
            : 'text-gray-600 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300'
        ]"
        @click="$emit('tab-selected', getOptionValue(option))"
    >
      <span class="relative z-10 whitespace-nowrap flex items-center">
        {{ getOptionLabel(option) }}
        <span v-if="isSelected(option)" class="ml-1.5 sm:ml-2 bg-indigo-100 dark:bg-indigo-900/60 text-indigo-700 dark:text-indigo-200 
                      rounded-full px-1.5 py-0.5 sm:px-2 text-[8px] sm:text-xs font-semibold">
          {{ getOptionCount(option) }}
        </span>
      </span>
      
      <span v-if="isSelected(option)" class="absolute inset-0 rounded-xl">
        <span class="absolute inset-0 rounded-xl border-2 border-transparent 
                    bg-gradient-to-r from-indigo-500 to-purple-600 dark:from-indigo-600 dark:to-purple-700 
                    opacity-70 -z-10"
              style="mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                     mask-composite: exclude;
                     -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                     -webkit-mask-composite: source-out;"></span>
        
        <span class="absolute inset-0 rounded-xl 
                    bg-gradient-to-r from-indigo-500/10 to-purple-600/10 dark:from-indigo-600/20 dark:to-purple-700/20 
                    blur-md opacity-40 -z-20"></span>
                    
        <span class="absolute inset-0 rounded-xl 
                    bg-white/90 dark:bg-gray-800/90"></span>
      </span>
    </button>
  </div>
</template>

<script setup>
const props = defineProps({
  options: {
    type: Array,
    required: true
  },
  selectedValue: {
    type: String,
    required: true
  }
})

defineEmits(['tab-selected'])

const getOptionValue = (option) => {
  return typeof option === 'object' ? option.value : option.toLowerCase().replace(/\s+/g, '_')
}

const getOptionLabel = (option) => {
  return typeof option === 'object' ? option.label : option
}

const getOptionCount = (option) => {
  return typeof option === 'object' ? option.count || '' : ''
}

const isSelected = (option) => {
  return getOptionValue(option) === props.selectedValue
}
</script>

<style scoped>
@keyframes selectTab {
  from {
    opacity: 0;
    transform: scale(0.96) translateY(2px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

button {
  will-change: transform, color, background-color;
}

button:active {
  transform: scale(0.98);
}
</style>