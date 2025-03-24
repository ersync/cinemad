<template>
  <div class="loading-circles">
	<div class="circle"></div>
	<div class="circle"></div>
	<div class="circle"></div>
  </div>
</template>

<style scoped>
.loading-circles {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
}

.circle {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background-color: #ffffff;
  opacity: 0.8;
  animation: pulse 1.5s infinite ease-in-out;
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
}

.circle:nth-child(1) {
  animation-delay: 0s;
}

.circle:nth-child(2) {
  animation-delay: 0.2s;
}

.circle:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes pulse {
  0%, 100% {
	transform: scale(0.6);
	opacity: 0.4;
  }
  50% {
	transform: scale(1);
	opacity: 1;
  }
}
</style>