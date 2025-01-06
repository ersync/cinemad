// app/frontend/services/chartInitializer.js
import EasyPieChart from 'easy-pie-chart'

export function initializeCharts() {
  const chartElements = document.querySelectorAll('[data-chart]')

  chartElements.forEach(element => {
    const options = {
      barColor: (percent) => {
        return (percent < 50 ? '#c4472c' : percent < 70 ? '#C5C82F' : '#66CE79')
      },
      trackColor: "#525151",
      scaleColor: false,
      lineCap: 'circle',
      lineWidth: 3,
      size: 49,
      animate: {
        duration: 1000,
        enabled: true
      }
    }

    const chart = new EasyPieChart(element, options)
    chart.update(parseFloat(element.dataset.percent))
  })
}