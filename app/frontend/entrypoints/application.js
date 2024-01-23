// Import external module
import {initializeEasyPieChart} from './easyPieChart';

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
  peopleSubmenu: document.querySelector(".people-submenu")
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
});
document.addEventListener('DOMContentLoaded', function () {
  initializeEasyPieChart('.medium-chart .user_score_chart', 54, 3, 2000);
});
document.addEventListener('DOMContentLoaded', function () {
  initializeEasyPieChart('.small-chart .user_score_chart', 42, 3, 2000);
});

// Prevent space input in the username field
document.addEventListener('DOMContentLoaded', function () {
  const usernameInput = document.getElementById('user_username')
  if (usernameInput) {
    usernameInput.addEventListener('keypress', function (e) {
      if (e.which === 32) {
        e.preventDefault()
      }
    })
  }
})
