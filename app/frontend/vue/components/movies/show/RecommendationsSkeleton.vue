<template>
  <ul class="flex gap-5 pb-4">
    <li v-for="n in 5" :key="n" class="shrink-0 snap-start" style="width: 300px;">
      <div class="relative h-[380px] rounded-xl overflow-hidden bg-gray-200 dark:bg-gray-800">
        <div class="shimmer-wrapper">
          <div class="shimmer"></div>
        </div>
        
        <!-- Top left rating -->
        <div class="absolute top-5 left-5">
          <div class="h-7 w-20 bg-gray-300 dark:bg-gray-700 rounded-full relative">
            <div class="shimmer-wrapper">
              <div class="shimmer"></div>
            </div>
          </div>
        </div>
        
        <!-- Middle left title -->
        <div class="absolute top-1/2 left-5 transform -translate-y-1/2">
          <div class="h-10 bg-gray-300 dark:bg-gray-700 w-48 rounded-md relative">
            <div class="shimmer-wrapper">
              <div class="shimmer"></div>
            </div>
          </div>
        </div>
      </div>
    </li>
  </ul>
</template>

<style scoped>
.shimmer-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.shimmer {
  width: 50%;
  height: 100%;
  background: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.3) 50%,
    rgba(255, 255, 255, 0) 100%
  );
  animation: shimmer 1.5s infinite;
  transform: skewX(-20deg);
}

@keyframes shimmer {
  0% {
    transform: translateX(-150%) skewX(-20deg);
  }
  100% {
    transform: translateX(200%) skewX(-20deg);
  }
}

@media (prefers-color-scheme: dark) {
  .shimmer {
    background: linear-gradient(
      90deg,
      rgba(255, 255, 255, 0) 0%,
      rgba(255, 255, 255, 0.1) 50%,
      rgba(255, 255, 255, 0) 100%
    );
  }
}
</style>