import {initializeEasyPieChart} from './easyPieChart';


// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

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

function toggleMenu() {
  elements.overlay.classList.toggle("overlay--visible");
  elements.mobileMenu.classList.toggle("-left-[90%]");
  elements.mobileMenu.classList.toggle("left-0");
}

function toggleSubmenu(submenu) {
  submenu.classList.toggle("submenu--open");
}

elements.mobileNavBtn.addEventListener("click", toggleMenu);
elements.overlay.addEventListener("click", toggleMenu);

elements.categoryMovies.addEventListener("click", () => toggleSubmenu(elements.moviesSubmenu));
elements.categoryTvShows.addEventListener("click", () => toggleSubmenu(elements.tvShowsSubmenu));
elements.categoryPeople.addEventListener("click", () => toggleSubmenu(elements.peopleSubmenu));


$(function () {
  initializeEasyPieChart('.big-chart .user_score_chart', 68, 5, 2000);
});

$(function () {
  initializeEasyPieChart('.small-chart .user_score_chart', 42, 3, 2000);
});
