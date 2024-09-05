export function initializeDOM() {
  const elements = {
    mobileNavBtn: document.querySelector(".mobile-nav-btn"),
    mobileMenuCloseBtn: document.querySelector(".mobile-close-btn"),
    overlay: document.querySelector(".overlay"),
    mobileMenu: document.querySelector(".mobile-menu"),
    categoryMovies: document.querySelector('.category-movies'),
    categoryTvShows: document.querySelector('.category-tv-shows'),
    categoryPeople: document.querySelector('.category-people'),
    moviesSubmenu: document.querySelector(".movies-submenu"),
    tvShowsSubmenu: document.querySelector(".tv-shows-submenu"),
    peopleSubmenu: document.querySelector(".people-submenu"),
    scrollableWrappers: document.querySelectorAll(".scrollable-wrapper"),
    scrollableContents: document.querySelectorAll(".scrollable-content"),
  }

  function toggleMenu() {
    elements.overlay.classList.toggle("overlay--visible")
    elements.mobileMenu.classList.toggle("-left-[80%]")
    elements.mobileMenu.classList.toggle("left-0")
  }

  function toggleSubmenu(submenu) {
    submenu.classList.toggle("submenu--open")
  }

  elements.mobileNavBtn.addEventListener("click", toggleMenu)
  elements.overlay.addEventListener("click", toggleMenu)

  elements.categoryMovies.addEventListener("click", () => toggleSubmenu(elements.moviesSubmenu))
  elements.categoryTvShows.addEventListener("click", () => toggleSubmenu(elements.tvShowsSubmenu))
  elements.categoryPeople.addEventListener("click", () => toggleSubmenu(elements.peopleSubmenu))

  function handleFading(wrapper) {
    const leftHorizontalOffset = wrapper.scrollLeft
    if (leftHorizontalOffset > 45) {
      wrapper.classList.add('fade_invisible')
      wrapper.classList.remove('fade_visible')
    } else {
      wrapper.classList.add('fade_visible')
      wrapper.classList.remove('fade_invisible')
    }
  }

  elements.scrollableWrappers.forEach(wrapper => {
    wrapper.addEventListener('scroll', () => handleFading(wrapper))
    new ScrollBooster({
      viewport: wrapper,
      content: wrapper.querySelector('.scrollable-content'),
      scrollMode: 'native',
      direction: 'horizontal'
    })
  })

  // Prevent space input in the username field
  const usernameInput = document.getElementById('user_username')
  if (usernameInput) {
    usernameInput.addEventListener('keypress', function (e) {
      if (e.which === 32) {
        e.preventDefault()
      }
    })
  }
}