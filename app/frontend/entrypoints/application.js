import '@/styles/application.scss'
import {initializeDOM} from "@/services/domManipulations"
import {mountComponents} from '@/vue/initializers/mountComponents'

document.addEventListener('DOMContentLoaded', () => {
  mountComponents()
})

initializeDOM()
