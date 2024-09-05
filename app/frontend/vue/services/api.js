// api.js
import Fetch from '../../services/fetch'
import NProgress from "nprogress"
import 'nprogress/nprogress.css'

export const getMovieRate = (movieId) => Fetch.get(`/movies/${movieId}/rate`)
export const getFavoriteStatus = (movieId) => Fetch.get(`/movies/${movieId}/favorite`)
export const getWatchlistStatus = (movieId) => Fetch.get(`/movies/${movieId}/watchlist`)
export const setMovieRate = (movieId, rate) => Fetch.post(`/movies/${movieId}/rate?rate=${rate}`)
export const unsetMovieRate = (movieId) => Fetch.delete(`/movies/${movieId}/rate`)
export const getAverageRate = (movieId) => Fetch.get(`/movies/${movieId}/avg_rate`)
export const updateState = async (endpoint, action, movieId) => {
  NProgress.start()
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content
  const response = await Fetch[action](`/movies/${movieId}/${endpoint}`, null, {
    headers: {'X-CSRF-Token': csrfToken}
  })
  NProgress.done()
  return response
}
export const getMedia = (movieId, mediaType) => Fetch.get(`/movies/${movieId}/${mediaType}`)
