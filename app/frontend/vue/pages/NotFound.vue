<template>
  <div class="cinematic-404 ">
	<div class="film-reel-container">
	  <div class="film-reel left"></div>
	  <div class="film-reel right"></div>
	</div>
	
	<div class="spotlight-container">
	  <div class="spotlight spotlight-left"></div>
	  <div class="spotlight spotlight-right"></div>
	</div>
	
	<div class="content-container scale-[80%]">
	  <h1 class="glitch-heading" data-text="404">404</h1>
	  
	  <div class="director-slate">
		<div class="slate-top">
		  <span>CINEMAD</span>
		  <span class="clapper" @click="animateClapper">▼</span>
		</div>
		<div class="slate-content">
		  <div class="slate-row">
			<span>SCENE:</span>
			<span>NOT FOUND</span>
		  </div>
		  <div class="slate-row">
			<span>TAKE:</span>
			<span>{{ takeNumber }}</span>
		  </div>
		  <div class="slate-row">
			<span>DIRECTOR:</span>
			<span>YOU</span>
		  </div>
		</div>
	  </div>
	  
	  <p class="error-message">The scene you're looking for is missing from our production.</p>
	  
	  <div class="action-buttons">
		<button class="neon-button" @click="goHome">
		  <span class="button-text">Back to Home</span>
		  <span class="button-glow"></span>
		</button>
		<button class="neon-button secondary" @click="searchMovies">
		  <span class="button-text">Discover Movies</span>
		  <span class="button-glow"></span>
		</button>
	  </div>
	  
	
	</div>	
	
	<div class="projector-beam"></div>
	
	
  </div>
</template>

<script>
export default {
  name: 'CinematicNotFound',
  data() {
	return {
	  takeNumber: 1,
	  clapperOpen: false
	}
  },
  mounted() {
	this.initializeGlitchEffect();
	this.animateSpotlights();
  },
  methods: {
	goHome() {
	  this.$router.push('/');
	},
	searchMovies() {
	  this.$router.push('/discovery');
	},
	animateClapper() {
	  if (!this.clapperOpen) {
		this.takeNumber++;
		this.clapperOpen = true;
		setTimeout(() => {
		  this.clapperOpen = false;
		}, 500);
	  }
	},
	initializeGlitchEffect() {
	  const glitchHeading = document.querySelector('.glitch-heading');
	  
	  setInterval(() => {
		glitchHeading.classList.add('glitch-active');
		
		setTimeout(() => {
		  glitchHeading.classList.remove('glitch-active');
		}, 200);
	  }, 3000);
	},
	animateSpotlights() {
	  const spotlights = document.querySelectorAll('.spotlight');
	  
	  spotlights.forEach(spotlight => {
		setInterval(() => {
		  const randomX = Math.random() * 10 - 5;
		  const randomY = Math.random() * 10 - 5;
		  
		  spotlight.style.transform = `translate(${randomX}px, ${randomY}px)`;
		}, 200);
	  });
	}
  }
}
</script>

<style scoped>
.cinematic-404 {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a192f 0%, #091428 100%);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  color: #ffffff;
  padding: 20px;
}

/* Film reel animation */
.film-reel-container {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: 0;
}

.film-reel {
  position: absolute;
  width: 120px;
  height: 120px;
  border-radius: 50%;
  border: 15px solid rgba(0, 0, 0, 0.5);
  background-color: #0a192f;
  box-shadow: 
	inset 0 0 15px rgba(0, 196, 196, 0.6),
	0 0 25px rgba(0, 196, 196, 0.4);
  animation: rotate 15s linear infinite;
}

.film-reel::before {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #0a192f;
  box-shadow: 0 0 10px rgba(0, 196, 196, 0.6);
}

.film-reel::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: radial-gradient(circle, transparent 35%, rgba(0, 0, 0, 0.7) 40%, transparent 45%);
  background-size: 20% 20%;
  animation: rotate 7s linear infinite reverse;
}

.film-reel.left {
  top: -60px;
  left: -60px;
}

.film-reel.right {
  bottom: -60px;
  right: -60px;
}

@keyframes rotate {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Spotlight effect */
.spotlight-container {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.spotlight {
  position: absolute;
  width: 100px;
  height: 100px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(0, 196, 196, 0.3) 0%, transparent 70%);
  filter: blur(8px);
  opacity: 0.7;
  transition: transform 0.3s ease-out;
}

.spotlight-left {
  top: 20%;
  left: 20%;
  width: 400px;
  height: 400px;
}

.spotlight-right {
  bottom: 20%;
  right: 20%;
  width: 300px;
  height: 300px;
}

/* Content container */
.content-container {
  position: relative;
  z-index: 2;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  max-width: 800px;
  padding: 40px;
  background: rgba(10, 25, 47, 0.8);
  border-radius: 20px;
  backdrop-filter: blur(10px);
  box-shadow: 0 0 30px rgba(0, 196, 196, 0.3);
  border: 1px solid rgba(0, 196, 196, 0.2);
}

/* Glitch 404 heading */
.glitch-heading {
  font-size: 12rem;
  font-weight: 900;
  margin: 0;
  position: relative;
  text-shadow: 0 0 10px rgba(0, 196, 196, 0.8);
  letter-spacing: -5px;
}

.glitch-heading::before,
.glitch-heading::after {
  content: attr(data-text);
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
}

.glitch-heading::before {
  animation: glitch-anim-1 0.2s infinite;
  color: #0ff;
  clip-path: polygon(0 0, 100% 0, 100% 33%, 0 33%);
  transform: translate(-2px, -2px);
}

.glitch-heading::after {
  animation: glitch-anim-2 0.3s infinite;
  color: #f0f;
  clip-path: polygon(0 67%, 100% 67%, 100% 100%, 0 100%);
  transform: translate(2px, 2px);
}

.glitch-heading.glitch-active::before,
.glitch-heading.glitch-active::after {
  opacity: 1;
}

@keyframes glitch-anim-1 {
  0% { transform: translate(0); }
  20% { transform: translate(-3px, 3px); }
  40% { transform: translate(-3px, -3px); }
  60% { transform: translate(3px, 3px); }
  80% { transform: translate(3px, -3px); }
  100% { transform: translate(0); }
}

@keyframes glitch-anim-2 {
  0% { transform: translate(0); }
  20% { transform: translate(5px, -5px); }
  40% { transform: translate(5px, 5px); }
  60% { transform: translate(-5px, -5px); }
  80% { transform: translate(-5px, 5px); }
  100% { transform: translate(0); }
}

/* Director slate */
.director-slate {
  width: 300px;
  margin: 20px 0 30px;
  background: #1a1a1a;
  border-radius: 5px;
  overflow: hidden;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
}

.slate-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 15px;
  background: #0a192f;
  color: #00c4c4;
  font-weight: bold;
  border-bottom: 2px solid #00c4c4;
}

.clapper {
  cursor: pointer;
  font-size: 1.2rem;
  transition: transform 0.3s ease;
}

.clapper:hover {
  color: #ffffff;
}

.slate-content {
  padding: 15px;
}

.slate-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  padding-bottom: 8px;
  border-bottom: 1px solid #333;
}

.slate-row:last-child {
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

/* Error message */
.error-message {
  font-size: 1.5rem;
  margin: 20px 0 30px;
  color: #ffffff;
  opacity: 0.8;
  font-weight: 300;
  max-width: 600px;
}

/* Action buttons */
.action-buttons {
  display: flex;
  gap: 20px;
  margin: 20px 0;
}

.neon-button {
  position: relative;
  padding: 15px 30px;
  background: transparent;
  color: #00c4c4;
  border: 2px solid #00c4c4;
  border-radius: 5px;
  font-weight: bold;
  font-size: 1rem;
  text-transform: uppercase;
  letter-spacing: 2px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s ease;
}

.neon-button:hover {
  color: #0a192f;
  background: #00c4c4;
  box-shadow: 0 0 20px rgba(0, 196, 196, 0.8);
}

.neon-button.secondary {
  color: #ffffff;
  border-color: #ffffff;
}

.neon-button.secondary:hover {
  color: #0a192f;
  background: #ffffff;
  box-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
}

.button-glow {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #00c4c4;
  z-index: -1;
  filter: blur(20px);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.neon-button:hover .button-glow {
  opacity: 0.5;
}


/* Projector beam */
.projector-beam {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, 
	transparent 0%, 
	rgba(0, 196, 196, 0.05) 30%, 
	rgba(0, 196, 196, 0.1) 70%, 
	transparent 100%);
  z-index: 1;
  pointer-events: none;
}


@media (max-width: 768px) {
  .glitch-heading {
	font-size: 6rem;
  }
  
  .action-buttons {
	flex-direction: column;
  }
  
  .director-slate {
	width: 250px;
  }
  
  .moving-frames {
	display: none;
  }
  
  .film-reel {
	width: 80px;
	height: 80px;
  }
  
  .spotlight {
	opacity: 0.4;
  }
  
  .cinema-seats {
	transform: rotateX(20deg) scale(0.7);
  }
}
</style>