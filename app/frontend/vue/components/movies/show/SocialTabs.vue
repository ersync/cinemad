<template>
  <div class="flex justify-between sm:justify-start items-center gap-[25px] sm:gap-[50px] mb-5 font-SourceProSemiBold antialiased">
    <h3 class="text-[1.4em]">Social</h3>
    <div class="flex items-center gap-6 text-[1.1em]">
      <h4
          :class="['pt-2 pb-1 rounded-b-sm', { 'border-b-4 border-black': activeTab === 'reviews' }]"
          @click="$emit('tab-change', 'reviews')"
      >
        Reviews <span class="text-black/60">{{ reviewCount }}</span>
      </h4>
      <h4
          :class="['pt-2 pb-1 rounded-b-sm', { 'border-b-4 border-black': activeTab === 'discussions' }]"
          @click="$emit('tab-change', 'discussions')"
      >
        Discussions <span class="text-black/60">{{ discussionCount }}</span>
      </h4>
    </div>
  </div>
</template>

<script setup>
defineProps({
  reviewCount: {
    type: Number,
    required: true
  },
  discussionCount: {
    type: Number,
    required: true
  },
  activeTab: {
    type: String,
    required: true
  }
})

defineEmits(['tab-change'])
</script>