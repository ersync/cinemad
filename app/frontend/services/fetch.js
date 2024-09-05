import axios from 'axios'

// Custom Error Class for HTTP Errors
class HttpError extends Error {
  constructor(message, status, url, data = null) {
    super(message)
    this.name = 'HttpError'
    this.status = status
    this.url = url
    this.data = data
  }
}

export default class Fetch {
  static async request(method, url, data = null, headers = {}) {
    try {
      const config = {
        method,
        url,
        headers,
        ...(data && {data}),
      }
      const response = await axios(config)
      // Check for successful status codes in the 2xx range
      if (response.status >= 200 && response.status < 300) {
        return response.data
      } else {
        throw new HttpError(
          `${method.toUpperCase()} request to ${url} failed with status ${response.status}`,
          response.status,
          url,
          response.data
        )
      }
    } catch (error) {
      if (error instanceof HttpError) {
        throw error
      }
      throw new HttpError(
        `${method.toUpperCase()} request to ${url} failed: ${error.message}`,
        error.response?.status || 0, // Default to 0 if no status
        url,
        error.response?.data || null
      )
    }
  }

  static get(url, headers = {}) {
    return this.request('GET', url, null, headers)
  }

  static post(url, data, headers = {}) {
    return this.request('POST', url, data, headers)
  }

  static delete(url, data = {}, headers = {}) {
    return this.request('DELETE', url, data, headers)
  }
}