<template>
  <div class="w-[130px] sm:w-[150px] shrink-0">
    <div class="relative">
      <div class="overflow-hidden rounded-lg min-h-[195px] sm:min-h-[225px] aspect-[2/3] bg-gray-200 dark:bg-gray-700/80 skeleton-base"></div>
    </div>
    
    <div class="pl-2 mt-3 sm:pl-2.5">
      <div class="h-4 sm:h-[18px] w-4/5 bg-gray-200 dark:bg-gray-700/80 skeleton-base rounded mb-1.5"></div>
      
      <div class="h-2 sm:h-3 bg-gray-200 dark:bg-gray-700/80 skeleton-base rounded w-2/5"></div>
    </div>
  </div>
</template>

<style scoped>
.skeleton-base {
  position: relative;
  overflow: hidden;
}

.skeleton-base::after {
  content: "";
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  transform: translateX(-100%);
  background-image: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0) 0,
    rgba(255, 255, 255, 0.2) 20%,
    rgba(255, 255, 255, 0.5) 60%,
    rgba(255, 255, 255, 0)
  );
  animation: shimmer 2s infinite;
}

@media (prefers-color-scheme: dark) {
  .skeleton-base::after {
    background-image: linear-gradient(
      90deg,
      rgba(255, 255, 255, 0) 0,
      rgba(255, 255, 255, 0.05) 20%,
      rgba(255, 255, 255, 0.1) 60%,
      rgba(255, 255, 255, 0)
    );
  }
}

:root.dark .skeleton-base::after {
  background-image: linear-gradient(
    90deg,
    rgba(255, 255, 255, 0) 0,
    rgba(255, 255, 255, 0.05) 20%,
    rgba(255, 255, 255, 0.1) 60%,
    rgba(255, 255, 255, 0)
  );
}

@keyframes shimmer {
  100% {
    transform: translateX(100%);
  }
}
</style>