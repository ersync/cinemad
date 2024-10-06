import '@/styles/application.scss'
import {initializeDOM} from "@/services/domManipulations"
import {mountComponents} from '@/vue/initializers/mountComponents'
import {initializeSkeletons} from '@/services/skeletonInitializer'

document.addEventListener('DOMContentLoaded', () => {
  mountComponents()
  initializeDOM()
  initializeSkeletons()
})
