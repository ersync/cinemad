export const calculateCursorPosition = (event) => {
  const ratingContainer = document.querySelector(".rating-container")
  const ratingContainerWidth = ratingContainer.offsetWidth
  const mouseX = event.clientX - ratingContainer.getBoundingClientRect().left
  return (mouseX / ratingContainerWidth) * 100
}

export const initializeEasyPieChart = (selector, size, lineWidth, animationDuration) => {
  $(selector).easyPieChart({
    size: size,
    lineWidth: lineWidth,
    animate: {
      duration: animationDuration,
      enabled: true
    },
    scaleColor: false,
    trackColor: '#fff',
    barColor: '#55bec0'
  })
}
