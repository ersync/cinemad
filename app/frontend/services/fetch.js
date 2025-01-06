import axios from 'axios'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

export class ApiError extends Error {
  constructor(message, status, data, config) {
    super(message)
    this.name = 'ApiError'
    this.status = status
    this.data = data
    this.config = config
  }
}

export default class Fetch {
  constructor(customConfig = {}) {
    this.axiosInstance = axios.create({
      timeout: 10000,
      ...customConfig
    })

    this.setupInterceptors()
  }

  setupInterceptors() {
    this.axiosInstance.interceptors.request.use(
      config => {
        NProgress.start()
        const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
        if (csrfToken) {
          config.headers['X-CSRF-Token'] = csrfToken
        }
        return config
      },
      error => {
        NProgress.done()
        return Promise.reject(error)
      }
    )

    this.axiosInstance.interceptors.response.use(
      response => {
        NProgress.done()
        return response
      },
      error => {
        NProgress.done()
        return Promise.reject(this.handleError(error)) // Return the rejected promise
      }
    )
  }

  handleError(error) {
    if (error.response) {
      return new ApiError(
        `Request failed with status ${error.response.status}`,
        error.response.status,
        error.response.data,
        error.config
      )
    } else if (error.request) {
      return new ApiError('No response received from the server', null, null, error.config)
    } else {
      return new ApiError('Error setting up the request', null, null, error.config)
    }
  }

  async makeRequest(method, url, data = null, headers = {}) {
    try {
      const config = {
        method,
        url,
        headers,
        data: data || undefined // Only include data if it exists
      }
      const response = await this.axiosInstance(config)
      return response.data
    } catch (error) {
      throw this.handleError(error) // Throw the error instead of just handling it
    }
  }
}