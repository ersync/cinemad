// app/frontend/entrypoints/application.js
import { initializeVueApps } from '@/vue/initializers/vueAppInitializer'
// import { initializeSkeletons } from '@/services/skeletonInitializer'
// import { initializeScrollBooster } from '@/modules/scrollBooster'
// import { initializeCharts } from '@/services/chartInitializer'
// import { initializeForms } from '@/services/formInitializer'

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', () => {
  // Initialize Vue apps first
  initializeVueApps()
  //
  // // Initialize other services
  // initializeSkeletons()
  // initializeCharts()
  // initializeForms()
})
//
// // Initialize scroll booster after all content is loaded
// window.addEventListener('load', () => {
//   setTimeout(initializeScrollBooster, 500)
// })