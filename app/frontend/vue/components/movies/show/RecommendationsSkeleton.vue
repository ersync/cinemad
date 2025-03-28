<template>
  <ul class="flex gap-5 pb-4">
    <li v-for="n in 5" :key="n" class="shrink-0 snap-start animate-pulse" style="width: 300px;">
      <div class="relative h-[380px] rounded-xl overflow-hidden bg-gray-200 border border-gray-200 shadow-sm">
        <div class="h-full w-full bg-gray-200"></div>
        
        <div class="absolute top-5 left-5">
          <div class="h-7 w-20 bg-gray-200 rounded-full"></div>
        </div>
        
        <div class="absolute bottom-5 left-5">
          <div class="h-8 bg-gray-200 w-48 rounded-md mb-2"></div>
          <div class="h-4 bg-gray-200 w-32 rounded-md"></div>
        </div>
      </div>
    </li>
  </ul>
</template>