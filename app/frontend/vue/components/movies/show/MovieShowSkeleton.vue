<template>
  <div>
	<!-- Full-width Header Skeleton -->
	<div class="min-h-[570px] w-full bg-slate-100">
	  <div class="h-full" style="background-image: linear-gradient(to right, rgba(241, 245, 249, 1) calc(-510px + 50vw), rgba(241, 245, 249, 0.84) 50%, rgba(241, 245, 249, 0.84) 100%);">
		<div class="container h-full min-h-[570px]">
		  <div class="flex justify-start items-center gap-6 lg:gap-10 h-full py-4 px-2 md:py-[30px] md:px-0">
			<!-- Poster Card -->
			<div class="relative">
			  <div class="flex flex-col shrink-0 w-[240px] md:w-[300px] h-[420px] md:h-[510px] rounded-lg overflow-hidden">
				<!-- Main poster area -->
				<div class="grow bg-slate-200"></div>
				<!-- Streaming info bar -->
				<div class="h-[60px] bg-slate-300"></div>
			  </div>
			</div>

			<!-- Content Area -->
			<div class="flex flex-col justify-center items-start grow">
			  <!-- Title Area -->
			  <div class="movie-header space-y-3">
				<div class="h-12 w-96 bg-slate-200 rounded-lg"></div>
				<!-- Single line for date and genre -->
				<div class="h-2 w-[500px] bg-slate-200 rounded-lg"></div>
			  </div>

			  <!-- User Score & Actions -->
			  <div class="flex items-center gap-5 my-8">
				<div class="h-[68px] w-[68px] bg-slate-200 rounded-full mr-10"></div>
				<div class="h-11 w-11 bg-slate-200 rounded-full"></div>
				<div class="h-11 w-11 bg-slate-200 rounded-full"></div>
				<div class="h-11 w-11 bg-slate-200 rounded-full"></div>
			  </div>

			  <!-- Tagline & Overview -->
			  <div class=" max-w-4xl">
				<div class="h-6 w-72 bg-slate-200 rounded-lg"></div>
				<div class="h-6 w-24 bg-slate-200 rounded-lg mt-4"></div>
				<div class="space-y-2 mt-10">
				  <div class="h-3 w-[900px] bg-slate-200 rounded-lg"></div>
				  <div class="h-3 w-[800px] bg-slate-200 rounded-lg"></div>
				</div>
				<div class="flex space-x-20 mt-10">
				  <div class="h-16 w-[100px] bg-slate-200 rounded-lg"></div>
				  <div class="h-16 w-[100px] bg-slate-200 rounded-lg"></div>
				  <div class="h-16 w-[100px] bg-slate-200 rounded-lg"></div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
	  </div>
	</div>

	<!-- Main Content Layout -->
	<div class="container">
	  <div class="flex gap-[10px] mt-[40px]">
		<!-- Left Column -->
		<div class="flex-1 gap-3">
		  <!-- Cast Section -->
		  <div class="bg-slate-200 w-[200px] h-6 rounded-lg mb-5"></div>
		  <div class="flex gap-3 items-center h-[320px] rounded-lg mb-8">
			<div class="bg-slate-200 w-[140px] h-[290px] rounded-lg"></div>
			<div class="bg-slate-200 w-[140px] h-[290px] rounded-lg"></div>
			<div class="bg-slate-200 w-[140px] h-[290px] rounded-lg"></div>
			<div class="bg-slate-200 w-[140px] h-[290px] rounded-md"></div>
			<div class="bg-slate-200 w-[140px] h-[290px] rounded-lg"></div>
		  </div>

		  <!-- Reviews Section -->
		  <div class="h-[300px] bg-slate-200 rounded-lg mb-8"></div>

		  <!-- Media Section -->
		  <div class="h-[380px] bg-slate-200 rounded-lg mb-8"></div>

		  <!-- Recommendations Section -->
		  <div class="h-[286px] bg-slate-200 rounded-lg"></div>
		</div>

		<!-- Right Column -->
		<div class="w-[295px] h-[700px] bg-slate-200 rounded-lg"></div>
	  </div>
	</div>
  </div>
</template>

<style scoped>
.animate-pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: .7; }
}

.container {
  @apply max-w-[1300px] mx-auto px-4;
}
</style>