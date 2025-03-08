<template>
  <div class="min-h-[calc(100vh-64px)] relative bg-gradient-to-br from-[#EEF2F6] via-[#F5F8FC] to-[#EDF1F9] flex items-center justify-center p-4 ">
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
              <div class="absolute inset-0 bg-gradient-to-r from-[#202035]/95 to-[#032541]/95 backdrop-blur-sm z-10"></div>
              <img
                  src="https://source.unsplash.com/random/?cinema,movie"
                  class="absolute inset-0 w-full h-full object-cover"
                  alt="Cinema"
              />
            </div>
            <div class="relative z-20 p-12 h-full flex flex-col justify-between">
              <div class="text-white space-y-6">
                <slot name="left-header">
                  <h1 class="text-5xl font-bold leading-tight animate-fade-in">
                    Welcome to <br/>
                    <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-200 to-sky-200">
                      CinEmad
                    </span>
                  </h1>
                  <p class="text-lg text-gray-200 leading-relaxed animate-fade-in-delay">
                    Your gateway to endless entertainment.
                    <br>Discover, rate, and track your favorite movies.
                  </p>
                </slot>
              </div>

              <slot name="testimonial">
                <blockquote class="text-white animate-fade-in-delay-2">
                  <p class="text-lg font-light italic">
                    "The ultimate movie companion for true film enthusiasts."
                  </p>
                  <footer class="mt-4">
                    <div class="flex items-center">
                      <div class="h-10 w-10 rounded-full bg-gradient-to-r from-blue-400 to-sky-400"></div>
                      <div class="ml-4">
                        <div class="text-base font-medium">Sarah Connor</div>
                        <div class="text-sm text-gray-300">Film Critic, Cinema Weekly</div>
                      </div>
                    </div>
                  </footer>
                </blockquote>
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