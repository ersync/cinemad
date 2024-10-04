import ScrollBooster from 'scrollbooster'

export function initializeDOM() {
  const elements = {
    scrollableWrappers: document.querySelectorAll(".scrollable-wrapper"),
    scrollableContents: document.querySelectorAll(".scrollable-content"),
  }

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

  function isTouchDevice() {
    return 'ontouchstart' in window || navigator.maxTouchPoints > 0 || navigator.msMaxTouchPoints > 0
  }

  elements.scrollableWrappers.forEach(wrapper => {
    wrapper.addEventListener('scroll', () => handleFading(wrapper))

    const content = wrapper.querySelector('.scrollable-content')

    if (!isTouchDevice()) {
      // Only initialize ScrollBooster for non-touch devices
      new ScrollBooster({
        viewport: wrapper,
        content: content,
        scrollMode: 'native',
        direction: 'horizontal',
      })
    } else {
      // For touch devices, ensure horizontal scrolling is possible
      wrapper.style.overflowX = 'auto'
      wrapper.style.WebkitOverflowScrolling = 'touch' // for smoother scrolling on iOS
    }
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