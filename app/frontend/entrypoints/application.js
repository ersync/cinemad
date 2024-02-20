const {createApp} = Vue
import Fetch from './js/fetch'
import {setupApp} from './js/vue'
import {setupApp2} from './js/vue2'
import axios from 'axios'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import {initializeEasyPieChart} from "./easypiechart"
import {initializeDOM} from "./js/domManipulations"

console.log('Vite ⚡️ Rails')


const app1 = createApp({setup: setupApp})
app1.mount('#app1')

const app2 = createApp({setup: setupApp2})
app2.mount('#app2')

initializeDOM()

