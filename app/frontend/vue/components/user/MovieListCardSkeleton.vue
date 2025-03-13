<template>
  <div class="h-[202px] shadow-medium gap-3.5 border border-tmdbLightGray rounded-lg overflow-hidden flex justify-start items-start mb-5">
    <div class="w-[133px] h-full shrink-0 bg-gray-200 animate-pulse">
      <div class="w-full h-full"></div>
    </div>

    <div class="flex flex-col justify-around h-full items-start py-3 pr-3.5 w-full">
      <div class="flex justify-center items-center gap-2.5 w-full">
        <div class="w-10 h-10 rounded-full bg-gray-200 animate-pulse"></div>

        <div class="flex-1">
          <div class="h-6 bg-gray-200 rounded-md w-3/4 animate-pulse"></div>
          <div class="h-4 bg-gray-200 rounded-md w-1/2 mt-2 animate-pulse"></div>
        </div>
      </div>

      <div class="mt-3 md:mt-4 w-full">
        <div class="h-4 bg-gray-200 rounded-md w-full animate-pulse"></div>
        <div class="h-4 bg-gray-200 rounded-md w-3/4 mt-2 animate-pulse"></div>
      </div>

      <div class="mt-3 md:mt-4 w-full">
        <ul class="flex justify-start gap-2 sm:gap-6 items-center">
          <li class="w-[117px] sm:w-[161px]">
            <div class="h-5 bg-gray-200 rounded-md w-full animate-pulse"></div>
          </li>

          <li>
            <div class="w-6 h-6 sm:w-8 sm:h-8 rounded-full bg-gray-200 animate-pulse"></div>
          </li>

          <li>
            <div class="w-6 h-6 sm:w-8 sm:h-8 rounded-full bg-gray-200 animate-pulse"></div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
</script>

<style scoped>
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.animate-pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}
</style>