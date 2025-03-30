<template>
  <ul class="flex gap-5 pb-4">
    <li 
      v-for="n in 5" 
      :key="n" 
      class="shrink-0 snap-start animate-pulse" 
      style="width: 300px;"
    >
      <div class="relative h-[380px] rounded-xl overflow-hidden 
                 bg-gray-100/70 dark:bg-gray-800/50 border border-gray-200/30 dark:border-gray-700/30">
        <!-- Main Skeleton -->
        <div class="h-full w-full bg-gradient-to-br from-gray-200/40 to-gray-100/60 dark:from-gray-700/40 dark:to-gray-800/60"></div>
        
        <!-- Rating Placeholder -->
        <div class="absolute top-5 right-5 h-7 w-16 rounded-full bg-gray-300/50 dark:bg-gray-600/50"></div>
        
        <!-- Title Placeholder -->
        <div class="absolute bottom-5 left-5 right-5 space-y-2">
          <div class="h-7 bg-gray-300/70 dark:bg-gray-600/70 rounded-md"></div>
          <div class="h-4 bg-gray-200/70 dark:bg-gray-700/70 rounded-md w-3/4"></div>
        </div>
      </div>
    </li>
  </ul>
</template>