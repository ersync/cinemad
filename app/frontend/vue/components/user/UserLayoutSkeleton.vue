<template>
  <div class="font-SourceProNormal antialiased">
	<div class="relative h-[300px] bg-gradient-to-r from-[#032541] to-[#034275] overflow-hidden">
	  <div class="relative mx-auto max-w-[1420px] h-full">
		<div class="container h-full">
		  <div class="flex h-full flex-row justify-center items-center flex-wrap gap-6 sm:gap-8 p-4">
			<div class="relative">
			  <div class="w-32 h-32 sm:w-44 sm:h-44 rounded-full ring-4 ring-white shadow-xl overflow-hidden bg-gray-300/30 animate-pulse">
			  </div>
			</div>

			<div class="flex-1 text-white">
			  <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4 mb-4">
				<div class="h-8 sm:h-10 w-36 sm:w-48 bg-gray-300/30 rounded-lg animate-pulse"></div>
				<div class="h-5 sm:h-6 w-28 sm:w-36 bg-gray-300/20 rounded-full animate-pulse"></div>
			  </div>

			  <div class="flex flex-wrap gap-6 text-white/90">
				<div class="flex items-center gap-3">
				  <div class="hidden sm:block w-[68px] h-[68px] rounded-full bg-gray-300/30 animate-pulse"></div>
				  <div class="sm:hidden w-[46px] h-[46px] rounded-full bg-gray-300/30 animate-pulse"></div>
				  <div class="space-y-1.5 sm:space-y-2">
					<div class="h-4 sm:h-5 w-24 sm:w-28 bg-gray-300/30 rounded animate-pulse"></div>
					<div class="h-3 sm:h-4 w-28 sm:w-32 bg-gray-300/20 rounded animate-pulse"></div>
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
	</div>

	<!-- Shortcut Bar Skeleton -->
	<nav class="w-full bg-white shadow-sm h-[48px] sm:h-[72px]">
	  <div class="max-w-6xl mx-auto sm:px-6 h-full">
		<ul class="flex items-center justify-center space-x-0.5 sm:space-x-4 h-full">
		  <li v-for="i in 4" :key="i" class="relative">
			<div class="flex items-center px-1.5 py-1 sm:px-5 sm:py-3 rounded-lg">
			  <div class="w-2.5 h-2.5 sm:w-5 sm:h-5 rounded bg-gray-200 animate-pulse mr-1 sm:mr-2"></div>
			  <div class="w-12 h-3.5 sm:w-16 sm:h-5 bg-gray-200 animate-pulse rounded"></div>
			</div>
		  </li>
		</ul>
	  </div>
	</nav>
  </div>
</template>