import axios from 'axios'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { useLoadingStore } from '@/vue/stores/loadingStore'

export const ErrorTypes = {
  UNAUTHORIZED: 'UNAUTHORIZED',
  FORBIDDEN: 'FORBIDDEN',
  VALIDATION: 'VALIDATION',
  NETWORK: 'NETWORK',
  SERVER: 'SERVER',
  UNKNOWN: 'UNKNOWN'
}

NProgress.configure({ showSpinner: false })

export class ApiError extends Error {
  constructor(message, type, status, data, config) {
    super(message)
    this.name = 'ApiError'
    this.type = type
    this.status = status
    this.data = data
    this.config = config
  }

  get userMessage() {
    return this.data?.errors?.[0] || this.message
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

        const skipLoaderPaths = [
          '/rate',
          '/favorite',
          '/watchlist',
          'search'
        ]

        const shouldSkipLoader = skipLoaderPaths.some(path =>
          config.url.includes(path)
        )

        if (!shouldSkipLoader) {
          const loadingStore = useLoadingStore()
          loadingStore.startLoading()
        }

        const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content
        if (csrfToken) {
          config.headers['X-CSRF-Token'] = csrfToken
        }

        return config
      },
      error => {
        this.cleanupLoading()
        return Promise.reject(this.handleError(error))
      }
    )

    this.axiosInstance.interceptors.response.use(
      response => {
        this.cleanupLoading(response.config.url)
        return response
      },
      error => {
        this.cleanupLoading(error.config?.url)
        return Promise.reject(this.handleError(error))
      }
    )
  }

  cleanupLoading(url = '') {
    NProgress.done()

    const skipLoaderPaths = [
      '/rate',
      '/favorite',
      '/watchlist',
      'search'
    ]

    const shouldSkipLoader = skipLoaderPaths.some(path =>
      url.includes(path)
    )

    if (!shouldSkipLoader) {
      const loadingStore = useLoadingStore()
      loadingStore.stopLoading()
    }
  }

  handleError(error) {
    if (error.response) {
      const { status, data, config } = error.response

      switch (status) {
        case 401:
          return new ApiError(
            data.errors?.[0] || 'Authentication required',
            ErrorTypes.UNAUTHORIZED,
            status,
            data,
            config
          )

        case 403:
          return new ApiError(
            'Access denied',
            ErrorTypes.FORBIDDEN,
            status,
            data,
            config
          )

        case 422:
          return new ApiError(
            data.errors?.[0] || 'Validation failed',
            ErrorTypes.VALIDATION,
            status,
            data,
            config
          )

        case 500:
        case 502:
        case 503:
          return new ApiError(
            'Server error occurred',
            ErrorTypes.SERVER,
            status,
            data,
            config
          )

        default:
          return new ApiError(
            'Request failed',
            ErrorTypes.UNKNOWN,
            status,
            data,
            config
          )
      }
    }

    if (error.request) {
      return new ApiError(
        'Network error occurred',
        ErrorTypes.NETWORK,
        null,
        null,
        error.config
      )
    }

    return new ApiError(
      'Request failed to initialize',
      ErrorTypes.UNKNOWN,
      null,
      null,
      error.config
    )
  }

  async makeRequest(method, url, data = null, headers = {}) {
    try {
      const config = {
        method,
        url,
        headers,
        data: data || undefined
      }

      const response = await this.axiosInstance(config)
      return response.data
    } catch (error) {
      throw error instanceof ApiError ? error : this.handleError(error)
    }
  }
}