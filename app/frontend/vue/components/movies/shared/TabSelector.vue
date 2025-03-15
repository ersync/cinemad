<template>
  <div class="inline-flex p-1 bg-[#fefefe10] backdrop-blur-md rounded-xl shadow-[0_4px_16px_rgba(0,0,0,0.06),inset_0_0_0_1px_rgba(255,255,255,0.1)] relative overflow-hidden before:content-[''] before:absolute before:inset-0 before:rounded-xl before:p-[1px] before:bg-gradient-to-br before:from-white/30 before:to-white/5 before:[mask:linear-gradient(#fff_0_0)_content-box,linear-gradient(#fff_0_0)] before:[mask-composite:exclude] before:pointer-events-none">
    <button
        v-for="option in options"
        :key="getOptionValue(option)"
        :class="[
          'relative py-1.5 px-2 rounded-lg text-sm font-medium tracking-[0.01em] transition-all duration-250 ease-[cubic-bezier(0.4,0,0.2,1)] overflow-hidden mx-0.5 cursor-pointer border-none bg-transparent outline-none sm:py-3 sm:px-5 sm:text-[15px]',
          isSelected(option)
            ? 'text-[#081422] font-semibold'
            : 'text-[rgba(94,92,100,1)] hover:text-gray-500 hover:bg-[#00000008]'
        ]"
        @click="$emit('tab-selected', getOptionValue(option))"
    >
      <span class="relative z-10">{{ getOptionLabel(option) }}</span>
      <div
          v-if="isSelected(option)"
    class="absolute inset-0 rounded-lg bg-gradient-to-b from-gray-200/50 to-slate-200/50 shadow-[0_2px_8px_rgba(0,0,0,0.05),0_0_0_1px_rgba(255,255,255,0.5)] backdrop-filter backdrop-blur-sm origin-center animate-[selectTab_0.3s_cubic-bezier(0.25,1,0.5,1)_forwards]"
      ></div>
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

const isSelected = (option) => {
  return getOptionValue(option) === props.selectedValue
}
</script>

<style scoped>
@keyframes selectTab {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
</style>