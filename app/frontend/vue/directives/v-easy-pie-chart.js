import EasyPieChart from 'easy-pie-chart'

export default {
  mounted(el, binding) {

    const options = {
      barColor: (percent) => {
        return (percent < 50 ? '#c4472c' : percent < 70 ? '#C5C82F' : '#66CE79')
      },
      trackColor: "#525151",
      scaleColor: false,
      lineCap: 'circle',
      lineWidth: binding.value.lineWidth || 3,
      size: binding.value.size || 110,
      animate: {
        duration: binding.value.duration || 1000,
        enabled: true
      },
      onStep: function (from, to, percent) {
      }
    }

    el._chart = new EasyPieChart(el, options)

    el._chart.update(0)

    el._currentValue = 0
    el._updateCount = 0
    el._lastUpdateTime = Date.now()

    // Force an update to the actual value after a short delay
    setTimeout(() => {
      el._chart.update(binding.value.percent || 0)
      el._currentValue = binding.value.percent || 0
    }, 50)
  },
  updated(el, binding) {
    el._updateCount++
    const now = Date.now()
    const timeSinceLastUpdate = now - el._lastUpdateTime

    if (el._chart && typeof el._chart.update === 'function' && el._currentValue !== binding.value.percent) {
      el._chart.update(binding.value.percent || 0)
      el._currentValue = binding.value.percent || 0
      el._lastUpdateTime = now
    }
  },
  unmounted(el) {
    if (el._chart && typeof el._chart.destroy === 'function') {
      el._chart.destroy()
    }
  }
}