import axios from 'axios'


export default class Fetch {
  static async get(url, headers = {}) {
    try {
      const response = await axios.get(url, {headers})
      if (response.status === 200) {
        return response.data
      } else {
        throw new Error(`GET request to ${url} failed with status ${response.status}`)
      }
    } catch (error) {
      throw new Error(`GET request to ${url} failed: ${error}`)
    }
  }

  static async post(url, data, headers = {}) {
    try {
      const response = await axios.post(url, data, {headers})
      if (response.status === 200) {
        return response.data
      } else {
        throw new Error(`POST request to ${url} failed with status ${response.status}`)
      }
    } catch (error) {
      throw new Error(`POST request to ${url} failed: ${error}`)
    }
  }

  static async delete(url, data, headers = {}) {
    try {
      const response = await axios.delete(url, data, {headers})
      if (response.status === 200) {
        return response.data
      } else {
        throw new Error(`DELETE request to ${url} failed with status ${response.status}`)
      }
    } catch (error) {
      throw new Error(`DELETE request to ${url} failed: ${error}`)
    }
  }
}