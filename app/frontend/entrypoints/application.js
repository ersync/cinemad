const ratingSteps = [
  {startPercentage: 21, endPercentage: 26.5, rate: 10, width: '10%'},
  {startPercentage: 26.5, endPercentage: 34.85, rate: 20, width: '20%'},
  {startPercentage: 34.85, endPercentage: 42, rate: 30, width: '30%'},
  {startPercentage: 42, endPercentage: 51, rate: 40, width: '40%'},
  {startPercentage: 51, endPercentage: 57, rate: 50, width: '50%'},
  {startPercentage: 57, endPercentage: 66, rate: 60, width: '60%'},
  {startPercentage: 66, endPercentage: 72, rate: 70, width: '70%'},
  {startPercentage: 72, endPercentage: 81, rate: 80, width: '80%'},
  {startPercentage: 81, endPercentage: 87, rate: 90, width: '90%'},
  {startPercentage: 87, endPercentage: 93, rate: 100, width: '100%'}
];

// Import external module

import axios from 'axios';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';

import {initializeEasyPieChart} from "./easypiechart";

// Log a message indicating the successful integration of Vite with Rails
console.log('Vite ⚡️ Rails');

// Log a link to the guide for more information
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails');

// DOM elements for easy reference
const elements = {
  mobileNavBtn: document.querySelector(".mobile-nav-btn"),
  mobileMenuCloseBtn: document.querySelector(".mobile-close-btn"),
  overlay: document.querySelector(".overlay"),
  mobileMenu: document.querySelector(".mobile-menu"),
  foo: document.querySelector(".foo"),
  categoryMovies: document.querySelector('.category-movies'),
  categoryTvShows: document.querySelector('.category-tv-shows'),
  categoryPeople: document.querySelector('.category-people'),
  moviesSubmenu: document.querySelector(".movies-submenu"),
  tvShowsSubmenu: document.querySelector(".tv-shows-submenu"),
  peopleSubmenu: document.querySelector(".people-submenu"),
  // todayTrending: document.querySelector(".trending-selector").firstElementChild,
  // weekTrending: document.querySelector(".trending-selector").lastElementChild,
  scrollableWrappers: document.querySelectorAll(".scrollable-wrapper"),
  scrollableContents: document.querySelectorAll(".scrollable-content"),
};

// Function to toggle the mobile menu visibility
function toggleMenu() {
  elements.overlay.classList.toggle("overlay--visible");
  elements.mobileMenu.classList.toggle("-left-[80%]");
  elements.mobileMenu.classList.toggle("left-0");
}

// Function to toggle submenu visibility
function toggleSubmenu(submenu) {
  submenu.classList.toggle("submenu--open");
}

// Event listeners for mobile navigation and submenus
elements.mobileNavBtn.addEventListener("click", toggleMenu);
elements.overlay.addEventListener("click", toggleMenu);

elements.categoryMovies.addEventListener("click", () => toggleSubmenu(elements.moviesSubmenu));
elements.categoryTvShows.addEventListener("click", () => toggleSubmenu(elements.tvShowsSubmenu));
elements.categoryPeople.addEventListener("click", () => toggleSubmenu(elements.peopleSubmenu));

// Initialize EasyPieChart on DOM content load for big and small charts
document.addEventListener('DOMContentLoaded', function () {

});

// Prevent space input in the username field
document.addEventListener('DOMContentLoaded', function () {
  const usernameInput = document.getElementById('user_username');
  if (usernameInput) {
    usernameInput.addEventListener('keypress', function (e) {
      if (e.which === 32) {
        e.preventDefault();
      }
    });
  }
});

function handleFading(wrapper) {
  const leftHorizontalOffset = wrapper.scrollLeft;
  if (leftHorizontalOffset > 45) {
    wrapper.classList.add('fade_invisible');
    wrapper.classList.remove('fade_visible');
  } else {
    wrapper.classList.add('fade_visible');
    wrapper.classList.remove('fade_invisible');
  }
}

// Loop through each scrollable wrapper and attach scrolling and fading functionality
elements.scrollableWrappers.forEach(wrapper => {
  wrapper.addEventListener('scroll', () => handleFading(wrapper));

  new ScrollBooster({
    viewport: wrapper,
    content: wrapper.querySelector('.scrollable-content'),
    scrollMode: 'native',
    direction: 'horizontal'
  });
});


const {createApp, ref, onMounted, computed, nextTick, watch} = Vue

createApp({
  setup() {
    const isFavorite = ref(false)
    const isInWatchlist = ref(false)
    const rate = ref(0);
    const avg_rate = ref(0);
    const rateWidth = computed(() => ratingSteps.find(step => step.rate === rate.value)?.width || 0)
    const hoveredRate = ref(rate.value)
    const hoveredRateWidth = ref(rateWidth.value)
    const movieId = document.getElementById('app').getAttribute('data-movie-id');


    const fetchRate = async (id) => {
      try {
        const response = await axios.get(`/movies/${id}/rate`);
        if (response.status === 200) {
          const {isRated, rate_score} = response.data;
          rate.value = isRated ? rate_score : 0
          hoveredRateWidth.value = rateWidth.value
        } else {
          throw new Error('Failed to fetch movie rate');
        }
      } catch (error) {
        console.error('Error fetching movie rate:', error);
      }
    }

    const fetchAvgRate = async (id) => {
      try {
        const response = await axios.get(`/movies/${id}/avg_rate`);
        if (response.status === 200) {
          avg_rate.value = response.data.avg_rate;
        } else {
          throw new Error('Failed to fetch movie rate');
        }
      } catch (error) {
        console.error('Error fetching average movie score:', error);
      }
    }

    const setRate = async (event) => {
      try {
        const cursorPosition = calculateCursorPosition(event)
        const newRate = ratingSteps.find(ratingStep => cursorPosition > ratingStep.startPercentage && cursorPosition < ratingStep.endPercentage)?.rate || 0
        const response = await axios.post(`/movies/${movieId}/rate?rate=${newRate}`)
        if (response.status === 200 && response.data.success) {
          rate.value = newRate
        } else {
          throw new Error('Failed to set movie rate.');
        }
      } catch (error) {
        console.error('Error setting movie rate:', error);
      }
    }

    const unrate = async (event) => {
      try {
        const response = await axios.delete(`/movies/${movieId}/rate`)
        if (response.status == 200) {
          rate.value = 0
        } else {
          throw new Error('Failed to unrate movie.');
        }
      } catch (error) {
        console.error('Error unrating movie:', error);
      }

    }
    watch(avg_rate, (newRate) => {
      // Update the EasyPieChart directly with the new rate value
      setTimeout(() => {
        $('.big-chart .movie_avg_rate').data('easyPieChart')?.update(newRate);
      }, 0)
    });

    watch(rate, async (oldRate, newRate) => {
      await fetchAvgRate(movieId);
    });

    const fetchInitialState = async (id) => {
      try {
        const [favoriteResponse, watchlistResponse] = await Promise.all([
          axios.get(`/movies/${id}/favorite`),
          axios.get(`/movies/${id}/watchlist`)
        ])
        if (watchlistResponse.status === 200) {
          isInWatchlist.value = watchlistResponse.data.isInWatchlist;
        }
        if (favoriteResponse.status === 200) {
          isFavorite.value = favoriteResponse.data.isFavorite;
        }
      } catch (error) {
        console.error('Error fetching initial state:', error);
      }
    }

    const updateWatchlist = async (id, action) => {
      try {
        NProgress.start()
        const response = await axios[action](`/movies/${id}/watchlist`, null, {
          headers: {'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content}
        })
        if (response.status == 200) {
          NProgress.done()
          isInWatchlist.value = response.data.isInWatchlist
        } else {
        }
      } catch (e) {
        console.error(`Error updating watchlist (action:${action}):`, error);
      }
    }
    const toggleWatchlist = () => {
      isInWatchlist.value ? updateWatchlist(movieId, 'delete') : updateWatchlist(movieId, 'post');
    }

    const updateFavorite = async (id, action) => {
      try {
        NProgress.start()
        const response = await axios[action](`/movies/${id}/favorite`, null, {
          headers: {'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content}
        })
        if (response.status == 200) {
          NProgress.done()
          isFavorite.value = response.data.isFavorite
        }
      } catch (e) {
        console.error(`Error updating favorite (action:${action}):`, error);
      }
    }
    const toggleFavorite = () => {
      isFavorite.value ? updateFavorite(movieId, 'delete') : updateFavorite(movieId, 'post');
    }


    const calculateCursorPosition = (event) => {
      const ratingContainer = document.querySelector(".rating-container")
      const ratingContainerWidth = ratingContainer.offsetWidth;
      const mouseX = event.clientX - ratingContainer.getBoundingClientRect().left;
      return (mouseX / ratingContainerWidth) * 100
    };

    const setHoveredRateWidth = (event) => {
      const cursorPosition = calculateCursorPosition(event);
      hoveredRateWidth.value = ratingSteps.find(step => cursorPosition > step.startPercentage && cursorPosition < step.endPercentage)?.width || '0';
    };

    const resetHoveredRateWidth = () => {
      const filledStars = document.querySelector(".filled-stars")
      hoveredRateWidth.value = rateWidth.value;
    }


    onMounted(async () => {
      await fetchInitialState(movieId)
      await fetchRate(movieId)
      await fetchAvgRate(movieId)
      initializeEasyPieChart('.big-chart .movie_avg_rate', 68, 5, 2000);
    });

    const rateClass = computed(() => {
      return `icon-r${avg_rate.value}`
    })
    return {
      isFavorite,
      isInWatchlist,
      toggleWatchlist,
      toggleFavorite,
      hoveredRateWidth,
      resetHoveredRateWidth,
      setHoveredRateWidth,
      rate,
      rateClass,
      avg_rate,
      setRate,
      unrate
    }
  }
}).mount('#app')
