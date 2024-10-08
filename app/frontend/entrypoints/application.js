import {mountComponents} from '@/vue/initializers/mountComponents'
import {initializeSkeletons} from '@/services/skeletonInitializer'
import {initializeScrollBooster} from '@/modules/scrollBooster'

document.addEventListener('DOMContentLoaded', () => {
  mountComponents()
  initializeSkeletons()
})
window.addEventListener('load', () => {
  setTimeout(() => {
    initializeScrollBooster()
  }, 500)
})