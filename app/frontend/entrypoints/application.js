const {createApp} = Vue
import {initializeDOM} from "../services/domManipulations"
import {movieRatingWidget} from '../vue/components/movieRatingWidget'
import {mediaGalleryWidget} from '../vue/components/mediaGalleryWidget'
import 'nprogress/nprogress.css'

const movieId = document.getElementById('movie-rating-container').getAttribute('data-movie-id')

console.log('Vite ⚡️ Rails')

// Initialize the movie rating widget
const movieRatingApp = createApp({
  setup() {
    return movieRatingWidget(movieId)
  }
})
movieRatingApp.mount('#movie-rating-container')

// Initialize the media gallery widget
const mediaGalleryApp = createApp({
  setup() {
    return mediaGalleryWidget(movieId)
  }
})
mediaGalleryApp.mount('#media-gallery-container')

// Initialize DOM manipulations
initializeDOM()