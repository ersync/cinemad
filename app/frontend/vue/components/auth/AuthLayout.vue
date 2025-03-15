<template>
  <div class="min-h-screen relative bg-gradient-to-br from-[#EEF2F6] via-[#F5F8FC] to-[#EDF1F9] flex items-center justify-center p-4 ">
    <!-- Animated background blobs -->
    <div class="absolute top-0 -left-4 w-72 h-72 bg-purple-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob"></div>
    <div class="absolute top-0 -right-4 w-72 h-72 bg-yellow-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob animation-delay-2000"></div>
    <div class="absolute -bottom-8 left-20 w-72 h-72 bg-pink-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 animate-blob animation-delay-4000"></div>

    <!-- Main container -->
    <div class="w-full max-w-5xl">
      <div class="backdrop-blur-sm bg-white/90 rounded-3xl shadow-[0_20px_50px_-12px_rgba(32,32,53,0.15)] overflow-hidden border border-white/20">
        <div class="md:grid md:grid-cols-2 h-full">
          <!-- Left side - Branding -->
          <div class="relative hidden md:block">
            <div class="absolute inset-0">
              <!-- Enhanced gradient overlay for better text visibility -->
              <div class="absolute inset-0 bg-gradient-to-br from-[#0F172A]/90 via-[#1E293B]/85 to-[#032541]/95 backdrop-blur-sm z-10"></div>
              
            </div>
            <div class="relative z-20 p-12 h-full flex flex-col justify-between">
              <div class="text-white space-y-8">
                <slot name="left-header">
                  <!-- Logo element -->
                  <div class="mb-8 animate-fade-in">
                    <div class="inline-block px-3 py-1 rounded-full bg-white/10 backdrop-blur-sm border border-white/20">
                      <span class="text-xl font-semibold tracking-wide text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-violet-300">CinEmad</span>
                    </div>
                  </div>
                  
                  <!-- Main heading with more dramatic typography -->
                  <h1 class="text-6xl font-bold leading-tight tracking-tight animate-fade-in">
                    The Ultimate<br/>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 via-blue-300 to-violet-300">
                      Film Experience
                    </span>
                  </h1>
                  
                  <!-- Improved subheading with better spacing and font -->
                  <p class="text-xl font-light text-gray-200 leading-relaxed animate-fade-in-delay max-w-md">
                    Discover, rate, and curate your cinematic journey with our award-winning platform designed for true film enthusiasts.
                  </p>
                  
                  <!-- Feature points -->
                  <div class="pt-4 space-y-3 animate-fade-in-delay">
                    <div class="flex items-center">
                      <div class="h-1.5 w-1.5 rounded-full bg-cyan-300 mr-3"></div>
                      <span class="text-gray-200">Access to 500,000+ films and series</span>
                    </div>
                    <div class="flex items-center">
                      <div class="h-1.5 w-1.5 rounded-full bg-cyan-300 mr-3"></div>
                      <span class="text-gray-200">Personalized recommendations</span>
                    </div>
                    <div class="flex items-center">
                      <div class="h-1.5 w-1.5 rounded-full bg-cyan-300 mr-3"></div>
                      <span class="text-gray-200">Join a community of film lovers</span>
                    </div>
                  </div>
                </slot>
              </div>
          
              <slot name="testimonial">
                <!-- Enhanced testimonial with better visual design -->
                <div class="bg-white/10 backdrop-blur-sm border border-white/20 rounded-xl p-6 animate-fade-in-delay-2 mt-5">
                  <div class="flex">
                    <!-- Star rating -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-300" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-300" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-300" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-300" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-300" viewBox="0 0 20 20" fill="currentColor">
                      <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
                    </svg>
                  </div>
                  
                  <p class="text-lg font-light italic text-gray-100">
                    "The perfect platform for cinephiles. CinEmad transformed how I discover and enjoy films."
                  </p>
                  
                  <div class="mt-5 flex items-center">
                    <div class="h-10 w-10 rounded-full bg-gradient-to-r from-cyan-400 to-blue-500 flex items-center justify-center text-white font-bold">
                      SC
                    </div>
                    <div class="ml-4">
                      <div class="text-base font-medium text-white">Sarah Connor</div>
                      <div class="text-sm text-gray-300 flex items-center">
                        <span>Film Critic, Cinema Weekly</span>
                        <span class="inline-block h-1.5 w-1.5 rounded-full bg-cyan-400 ml-2"></span>
                      </div>
                    </div>
                  </div>
                </div>
              </slot>
            </div>
          </div>

          <!-- Right side - Form -->
          <div class="p-6 pt-2 sm:p-8 bg-white/80 backdrop-blur-sm">
            <div class="w-full max-w-md mx-auto space-y-8">
              <slot></slot>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.animate-blob {
  animation: blob 7s infinite;
}
.animation-delay-2000 {
  animation-delay: 2s;
}
.animation-delay-4000 {
  animation-delay: 4s;
}

@keyframes blob {
  0% {
    transform: translate(0px, 0px) scale(1);
  }
  33% {
    transform: translate(20px, -30px) scale(1.1);
  }
  66% {
    transform: translate(-10px, 10px) scale(0.9);
  }
  100% {
    transform: translate(0px, 0px) scale(1);
  }
}

.animate-fade-in {
  animation: fadeIn 0.8s ease-out;
}

.animate-fade-in-delay {
  animation: fadeIn 0.8s ease-out 0.2s both;
}

.animate-fade-in-delay-2 {
  animation: fadeIn 0.8s ease-out 0.4s both;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>