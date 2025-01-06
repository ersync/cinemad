<template>
  <ul class="flex gap-4 pb-2.5">
    <li v-for="n in 5" :key="n" class="shrink-0">
      <div class="w-[250px] h-[141px] bg-gray-200 rounded-lg relative">
        <div class="shimmer-wrapper">
          <div class="shimmer"></div>
        </div>
      </div>
      <div class="flex justify-between items-center mt-1">
        <div class="h-4 bg-gray-200 w-24 rounded relative">
          <div class="shimmer-wrapper">
            <div class="shimmer"></div>
          </div>
        </div>
        <div class="h-4 bg-gray-200 w-8 rounded relative">
          <div class="shimmer-wrapper">
            <div class="shimmer"></div>
          </div>
        </div>
      </div>
    </li>
  </ul>
</template>