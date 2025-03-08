<template>
  <li>
    <div class="w-[100px] sm:w-[140px] overflow-hidden rounded-lg border border-tmdbLightGray mb-2.5 pb-2.5 shadow-light">
      <div class="h-[147px] sm:h-[207px] bg-gray-200 flex items-center justify-center relative">
        <svg class="w-3/4 relative z-10">
          <use xlink:href="#user-skeleton"></use>
        </svg>
        <div class="shimmer-wrapper">
          <div class="shimmer"></div>
        </div>
      </div>
      <div class="mt-3 mx-2.5 text-left ">
        <div class="h-4 sm:h-5 bg-gray-200 rounded w-3/4 mb-1 relative">
          <div class="shimmer-wrapper">
            <div class="shimmer"></div>
          </div>
        </div>
        <div class="h-3 sm:h-4 bg-gray-200 rounded w-1/2 relative">
          <div class="shimmer-wrapper">
            <div class="shimmer"></div>
          </div>
        </div>
      </div>
    </div>
  </li>
</template>