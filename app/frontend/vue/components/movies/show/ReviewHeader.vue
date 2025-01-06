<template>
  <div>
    <span class="inline-block font-SourceProLight text-[1.1rem]">Featured Review</span>
    <h5 class="font-SourceProBold text-[1.3rem] leading-[1.3rem]">
      A review by {{ review.user.username }}
    </h5>
    <div class="text-[0.9rem] font-SourceProLight">
      <span class="text-white inline-flex justify-center items-center gap-0.5 bg-black px-2 mr-2 rounded-lg">
        <svg class="inline-block w-[14px] h-[14px]">
          <use xlink:href="#star"></use>
        </svg>
        <span class="inline-block">{{ review.rating }}</span>
      </span>
      <span>
        Written by
        <span class="font-SourceProNormal">{{ review.user.username }}</span>
        on
        <span>{{ review.created_at }}</span>
      </span>
    </div>
  </div>
</template>

<script setup>
defineProps({
  review: {
    type: Object,
    required: true
  }
})
</script>