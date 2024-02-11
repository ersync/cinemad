// Import external module
import {initializeEasyPieChart} from './easyPieChart';

import axios from 'axios';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';

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
  initializeEasyPieChart('.big-chart .user_score_chart', 68, 5, 2000);
  initializeEasyPieChart('.medium-chart .user_score_chart', 54, 3, 2000);
  initializeEasyPieChart('.base-chart .user_score_chart', 42, 3, 2000);
  initializeEasyPieChart('.small-chart .user_score_chart', 38, 3, 2000);
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


const {createApp, ref, onMounted} = Vue

createApp({
  setup() {
    const isFavorite = ref(false)
    const isInWatchlist = ref(false)
    const movieId = document.getElementById('app').getAttribute('data-movie-id');

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
      } catch (e) {
        console.error('Error fetching initial state:', e);
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


    onMounted(() => {
      fetchInitialState(movieId)
    });

    return {
      isFavorite,
      isInWatchlist,
      toggleWatchlist,
      toggleFavorite
    }
  }
}).mount('#app')
