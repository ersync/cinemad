<template>
  <div class="min-h-screen bg-gradient-to-br from-[#010e19] via-[#011a30] to-[#010e19] flex items-center justify-center p-4 relative overflow-hidden">
	<!-- Decorative background elements -->
	<div class="absolute inset-0 overflow-hidden">
	  <div class="absolute top-1/4 left-1/4 w-96 h-96 rounded-full bg-blue-500/5 blur-3xl opacity-40"></div>
	  <div class="absolute bottom-1/4 right-1/3 w-80 h-80 rounded-full bg-indigo-500/5 blur-3xl opacity-30"></div>
	</div>
	
	<!-- Main container -->
	<div class="relative z-10 w-full max-w-md transform transition-all duration-700" :class="animationClass">
	  <div class="backdrop-blur-md bg-[#011528]/80 rounded-2xl border border-blue-500/10 shadow-[0_20px_50px_-12px_rgba(3,37,65,0.25)] overflow-hidden">
		<!-- Logo header -->
		<div class="pt-8 px-8 flex justify-center">
		  <div class="inline-block px-3 py-1 rounded-full bg-white/10 backdrop-blur-sm border border-white/20">
			<span class="text-xl font-semibold tracking-wide text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-violet-300">CinEmad</span>
		  </div>
		</div>

		<!-- Status icon -->
		<div class="mt-6 flex justify-center">
		  <!-- Loading state -->
		  <div v-if="loading" class="relative w-20 h-20 flex items-center justify-center">
			<div class="absolute inset-0 rounded-full border-t-2 border-blue-400/30 animate-spin"></div>
			<div class="absolute inset-0 rounded-full border-t-2 border-l-2 border-blue-500 animate-spin-slow"></div>
			<div class="absolute inset-0 rounded-full border-t border-blue-300/20 animate-pulse"></div>
			<div class="w-12 h-12 rounded-full bg-gradient-to-br from-blue-500/20 to-indigo-500/20 backdrop-blur-sm flex items-center justify-center">
			  <svg class="w-6 h-6 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z" />
			  </svg>
			</div>
		  </div>

		  <!-- Success state -->
		  <div v-else-if="success" class="w-20 h-20 rounded-full bg-gradient-to-br from-[#032541]/80 to-[#202035]/80 backdrop-blur-sm flex items-center justify-center relative animate-bounce-once">
			<div class="absolute inset-0 rounded-full bg-green-500/10 animate-pulse"></div>
			<svg class="w-10 h-10 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
			  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
			</svg>
		  </div>

		  <!-- Error state -->
		  <div v-else class="w-20 h-20 rounded-full bg-gradient-to-br from-[#032541]/80 to-[#202035]/80 backdrop-blur-sm flex items-center justify-center relative">
			<div class="absolute inset-0 rounded-full bg-red-500/10 animate-pulse"></div>
			<svg class="w-10 h-10 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
			  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
			</svg>
		  </div>
		</div>

		<!-- Status text -->
		<div class="mt-6 px-8 text-center">
		  <h2 class="text-2xl font-semibold text-transparent bg-clip-text bg-gradient-to-r from-white via-blue-100 to-white">{{ message }}</h2>
		  <p class="mt-2 text-blue-300/80">{{ subMessage }}</p>
		</div>

		<!-- Error message -->
		<div v-if="errorMessage" class="mt-6 mx-8 text-red-400/90 p-4 bg-red-500/10 backdrop-blur-sm rounded-lg border border-red-500/20 text-sm">
		  {{ errorMessage }}
		</div>

		<!-- Action button -->
		<div class="mt-8 mb-8 px-8 flex justify-center">
		  <button 
			v-if="!loading && !redirecting" 
			@click="handleContinue" 
			class="group relative px-6 py-3 rounded-lg bg-gradient-to-r from-blue-600/80 to-indigo-600/80 text-white font-medium text-sm shadow-lg shadow-blue-500/10 hover:shadow-blue-500/20 transition-all duration-300 overflow-hidden"
		  >
			<div class="absolute inset-0 flex items-center justify-center">
			  <div class="h-[200%] w-[200%] animate-slow-spin rounded-full bg-gradient-to-tr from-blue-500/0 via-blue-500/30 to-blue-500/0 opacity-0 transition-opacity duration-500 group-hover:opacity-100"></div>
			</div>
			<span class="relative flex items-center">
			  <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
			  </svg>
			  Continue to Cinemad
			</span>
		  </button>
		</div>
	  </div>
	</div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useAuthStore } from '@/vue/stores/authStore';

const router = useRouter();
const route = useRoute();
const authStore = useAuthStore();

const loading = ref(true);
const success = ref(false);
const errorMessage = ref(null);
const redirecting = ref(false);
const message = ref('Connecting the Stars...');
const subMessage = ref('Finalizing your authentication experience');

const animationClass = computed(() => {
  if (loading.value) return 'scale-100';
  if (success.value) return 'scale-105';
  return 'scale-100';
});

function handleContinue() {
  redirecting.value = true;
  router.push('/');
}

onMounted(async () => {
  try {
	const successParam = route.query.success;
	const errorParam = route.query.error;
	
	if (errorParam) {
	  loading.value = false;
	  success.value = false;
	  message.value = 'Authentication Failed';
	  subMessage.value = 'Unable to complete the sign-in process.';
	  errorMessage.value = decodeURIComponent(errorParam);
	  return;
	}
	
	await new Promise(resolve => setTimeout(resolve, 1800));
	
	const isAuthenticated = await authStore.checkAuth();
	
	if (isAuthenticated) {
	  loading.value = false;
	  success.value = true;
	  message.value = 'Welcome Back!';
	  subMessage.value = 'Your cinematic journey awaits.';
	  
	  setTimeout(() => {
		redirecting.value = true;
		router.push('/');
	  }, 2000);
	} else {
	  loading.value = false;
	  success.value = false;
	  message.value = 'Authentication Issue';
	  subMessage.value = 'We couldn\'t verify your credentials.';
	  errorMessage.value = 'Please try again or use another sign-in method.';
	}
  } catch (error) {
	console.error('Authentication callback error:', error);
	loading.value = false;
	success.value = false;
	message.value = 'Something Went Wrong';
	subMessage.value = 'We encountered an unexpected error.';
	errorMessage.value = error.message || 'Unknown error occurred.';
  }
});
</script>

<style scoped>
@keyframes slow-spin {
  from {
	transform: rotate(0deg);
  }
  to {
	transform: rotate(360deg);
  }
}

.animate-slow-spin {
  animation: slow-spin 15s linear infinite;
}

.animate-spin-slow {
  animation: spin 3s linear infinite;
}

@keyframes spin {
  from {
	transform: rotate(0deg);
  }
  to {
	transform: rotate(360deg);
  }
}

.animate-bounce-once {
  animation: bounce 1.5s ease;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
  40% {transform: translateY(-20px);}
  60% {transform: translateY(-10px);}
}
</style>