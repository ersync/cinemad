<template>
  <div class="w-[130px] sm:w-[150px] shrink-0">
	<div class="relative">
	  <div class="overflow-hidden rounded-lg min-h-[195px] sm:min-h-[225px] aspect-[2/3] bg-slate-200 skeleton-animation"></div>
	  
	</div>
	
	<div class="pl-2 mt-3 sm:pl-2.5">
	  <div class="h-4 sm:h-[18px] w-4/5 bg-slate-200 skeleton-animation rounded mb-1.5"></div>
	  
	  <div class="h-2 sm:h-3 bg-slate-200 skeleton-animation rounded w-2/5"></div>
	</div>
  </div>
</template>


<style scoped>
.skeleton-animation {
  background: linear-gradient(
	90deg,
	rgba(226, 232, 240, 0.6) 0%, 
	rgba(226, 232, 240, 0.8) 50%, 
	rgba(226, 232, 240, 0.6) 100%
  );
  background-size: 200% 100%;
  animation: skeleton-loading 1.5s infinite;
}

@keyframes skeleton-loading {
  0% {
	background-position: 200% 0;
  }
  100% {
	background-position: -200% 0;
  }
}
</style>