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
  });
}

export {initializeEasyPieChart};

