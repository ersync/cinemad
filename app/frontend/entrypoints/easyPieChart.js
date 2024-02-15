function initializeEasyPieChart(selector, size, lineWidth, animateDuration) {
  $(selector).easyPieChart({
    size: size,
    barColor: function (percent) {
      return (percent < 50 ? '#c4472c' : percent < 70 ? '#C5C82F' : '#66CE79');
    },
    scaleLength: 0,
    lineWidth: lineWidth,
    trackColor: "#525151",
    lineCap: "circle",
    animate: animateDuration,
    onStart: function (from, to) {
      let counter = from
      const increment = from < to ? 1 : -1
      const interval = setInterval(() => {
        if (counter === to) {
          clearInterval(interval)
        } else {
          counter += increment
        }
        this.el.firstElementChild.textContent = counter
      }, 110 - Math.abs(from - to))
    }
  });
}

export {initializeEasyPieChart};

