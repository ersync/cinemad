const {createApp} = Vue
import Fetch from './js/fetch'
import {setupApp} from './js/vue'
import axios from 'axios'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import {initializeEasyPieChart} from "./easypiechart"
import {initializeDOM} from "./js/domManipulations"

console.log('Vite ⚡️ Rails')

initializeDOM()

const app = createApp({setup: setupApp})
app.mount('#app')