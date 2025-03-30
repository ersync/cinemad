<template>
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div class="stats-card group relative overflow-hidden" data-aos="fade-up" data-aos-delay="100">
      <div class="card-glow"></div>
      <div class="text-center">
        <div class="stats-number">
          {{ user.avg_rating }}%
        </div>
        <div class="stats-label">Your Average Rating</div>
      </div>
    </div>
    
    <div class="stats-card group relative overflow-hidden" data-aos="fade-up" data-aos-delay="200">
      <div class="card-glow"></div>
      <div class="text-center">
        <div class="stats-number">
          {{ user.stats?.total_ratings || 0 }}
        </div>
        <div class="stats-label">Total Ratings</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted } from "vue"  

defineProps({
  user: {
    type: Object,
    required: true
  }
})

onMounted(() => {
  const cards = document.querySelectorAll('.stats-card');
  
  cards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      
      const xPercent = x / rect.width * 100;
      const yPercent = y / rect.height * 100;
      
      card.style.setProperty('--mouse-x', `${xPercent}%`);
      card.style.setProperty('--mouse-y', `${yPercent}%`);
    });
  });
});
</script>

<style scoped>
.stats-card {
  @apply px-8 py-6 rounded-2xl transition-all duration-300 transform hover:-translate-y-1;
  background: rgba(255, 255, 255, 0.03);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
  position: relative;
}

.stats-card:hover {
  background: rgba(255, 255, 255, 0.05);
}

.stats-number {
  @apply text-4xl font-bold mb-2;
  background: linear-gradient(135deg, #60A5FA, #C084FC);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.stats-label {
  @apply text-sm text-gray-300 font-medium text-gray-500;
}

.card-glow {
  position: absolute;
  inset: 0;
  background: radial-gradient(
      circle at var(--mouse-x, 50%) var(--mouse-y, 50%),
      rgba(255, 255, 255, 0.1) 0%,
      transparent 50%
  );
  opacity: 0;
  transition: opacity 0.3s;
}

.stats-card:hover .card-glow {
  opacity: 1;
}

@media (max-width: 768px) {
  .stats-card {
    @apply px-6 py-4;
  }

  .stats-number {
    @apply text-2xl;
  }

  .stats-label {
    @apply text-xs;
  }
}
</style>