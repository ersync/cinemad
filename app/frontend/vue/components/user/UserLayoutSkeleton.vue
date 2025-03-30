<template>
  <div class="font-SourceProNormal antialiased">
	<div class="relative h-[300px] bg-gradient-to-r from-[#032541] to-[#034275] dark:from-[#010108] dark:via-[#111a4b] dark:to-[#0a0118] overflow-hidden">
	  <!-- Dark mode animated particles -->
	  <div class="absolute inset-0 w-full h-full dark:block hidden">
		<div class="stars-container">
		  <div class="stars"></div>
		  <div class="stars2"></div>
		  <div class="shooting-stars"></div>
		  <div class="shooting-star-extra"></div>
		  <div class="shooting-star-extra2"></div>
		</div>
	  </div>
	  
	  <div class="relative mx-auto max-w-[1420px] h-full">
		<div class="container h-full">
		  <div class="flex h-full flex-row justify-center items-center flex-wrap gap-6 sm:gap-8 p-4">
			<div class="relative">
			  <div class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white dark:ring-indigo-500/30 shadow-xl overflow-hidden bg-gray-300/30 dark:bg-gray-700/30 animate-pulse">
			  </div>
			</div>

			<div class="flex-1 text-white">
			  <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4 mb-4">
				<div class="h-8 sm:h-10 w-36 sm:w-48 bg-gray-300/30 dark:bg-gray-700/30 rounded-lg animate-pulse"></div>
				<div class="h-5 sm:h-6 w-28 sm:w-36 bg-gray-300/20 dark:bg-gray-700/20 rounded-full animate-pulse"></div>
			  </div>

			  <div class="flex flex-wrap gap-6 text-white/90">
				<div class="flex items-center gap-3">
				  <div class="hidden sm:block w-[68px] h-[68px] rounded-full bg-gray-300/30 dark:bg-gray-700/30 animate-pulse"></div>
				  <div class="sm:hidden w-[46px] h-[46px] rounded-full bg-gray-300/30 dark:bg-gray-700/30 animate-pulse"></div>
				  <div class="space-y-1.5 sm:space-y-2">
					<div class="h-4 sm:h-5 w-24 sm:w-28 bg-gray-300/30 dark:bg-gray-700/30 rounded animate-pulse"></div>
					<div class="h-3 sm:h-4 w-28 sm:w-32 bg-gray-300/20 dark:bg-gray-700/20 rounded animate-pulse"></div>
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
	</div>

	<nav class="w-full bg-white dark:bg-gray-800 shadow-sm dark:shadow-gray-900/30 h-[48px] sm:h-[72px]">
	  <div class="max-w-6xl mx-auto sm:px-6 h-full">
		<ul class="flex items-center justify-center space-x-0.5 sm:space-x-4 h-full">
		  <li v-for="i in 4" :key="i" class="relative">
			<div class="flex items-center px-1.5 py-1 sm:px-5 sm:py-3 rounded-lg">
			  <div class="w-2.5 h-2.5 sm:w-5 sm:h-5 rounded bg-gray-200 dark:bg-gray-700 animate-pulse mr-1 sm:mr-2"></div>
			  <div class="w-12 h-3.5 sm:w-16 sm:h-5 bg-gray-200 dark:bg-gray-700 animate-pulse rounded"></div>
			</div>
		  </li>
		</ul>
	  </div>
	</nav>
  </div>
</template>

<style scoped>
/* Stars animation for dark mode */
.stars-container {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
  transform: translateZ(0);
}

.stars, .stars2 {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: 
	radial-gradient(2px 2px at 20px 30px, #edf2f7, rgba(0,0,0,0)),
	radial-gradient(2px 2px at 40px 70px, #f7fafc, rgba(0,0,0,0)),
	radial-gradient(1px 1px at 90px 40px, #e2e8f0, rgba(0,0,0,0)),
	radial-gradient(2px 2px at 160px 120px, #edf2f7, rgba(0,0,0,0)),
	radial-gradient(1px 1px at 230px 50px, #f7fafc, rgba(0,0,0,0));
  background-repeat: repeat;
  background-size: 250px 250px;
  opacity: 0.15;
  animation: stars-move 100s linear infinite;
}

.stars2 {
  background-image: 
	radial-gradient(1px 1px at 25px 5px, #edf2f7, rgba(0,0,0,0)),
	radial-gradient(1px 1px at 50px 25px, #f7fafc, rgba(0,0,0,0)),
	radial-gradient(1px 1px at 125px 20px, #e2e8f0, rgba(0,0,0,0)),
	radial-gradient(1.5px 1.5px at 190px 90px, #edf2f7, rgba(0,0,0,0)),
	radial-gradient(1.5px 1.5px at 200px 60px, #f7fafc, rgba(0,0,0,0));
  background-size: 200px 200px;
  animation-delay: 50ms;
}

.shooting-stars {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.shooting-stars::before, .shooting-stars::after {
  content: "";
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
}

.shooting-stars::before {
  animation: shooting-star 12s linear infinite;
  top: 20%;
  left: 80%;
}

.shooting-stars::after {
  animation: shooting-star 10s linear infinite;
  animation-delay: 2.5s;
  top: 30%;
  left: 70%;
}

.shooting-star-extra {
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
  animation: shooting-star 10s linear infinite;
  animation-delay: 5s;
  top: 15%;
  left: 60%;
}

.shooting-star-extra2 {
  position: absolute;
  width: 100px;
  height: 1px;
  background: linear-gradient(to right, rgba(0,0,0,0), #fff, rgba(0,0,0,0));
  transform: rotate(-45deg);
  opacity: 0;
  animation: shooting-star 12s linear infinite;
  animation-delay: 7.5s;
  top: 40%;
  left: 75%;
}

@keyframes stars-move {
  from {
	background-position: 0 0;
  }
  to {
	background-position: 250px 250px;
  }
}

@keyframes shooting-star {
  0% {
	transform: translateX(0) translateY(0) rotate(-45deg);
	opacity: 0;
  }
  2% {
	opacity: 1;
  }
  4% {
	transform: translateX(-100px) translateY(100px) rotate(-45deg);
	opacity: 0;
  }
  100% {
	transform: translateX(-100px) translateY(100px) rotate(-45deg);
	opacity: 0;
  }
}
</style>