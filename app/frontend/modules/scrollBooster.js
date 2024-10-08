import ScrollBooster from 'scrollbooster'

export function initializeScrollBooster() {
  const wrappers = document.querySelectorAll('.scrollable-wrapper')
  wrappers.forEach(wrapper => {
    const content = wrapper.querySelector('.scrollable-content')

    if (!isTouchDevice()) {
      new ScrollBooster({
        viewport: wrapper,
        content: content,
        scrollMode: 'native',
        direction: 'horizontal',
      })
    } else {
      wrapper.style.overflowX = 'auto'
      wrapper.style.WebkitOverflowScrolling = 'touch'
    }

    wrapper.addEventListener('scroll', () => handleFading(wrapper))
  })
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