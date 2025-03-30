import Fetch, { ErrorTypes, ApiError } from '@/services/fetch'

class AuthApiService {
  constructor() {
    this.fetchInstance = new Fetch()
  }

  async getCurrentUser() {
    try {
      return await this.fetchInstance.makeRequest('get', '/api/users/current')
    } catch (error) {
      if (error.type === ErrorTypes.UNAUTHORIZED) {
        return { success: false }
      }
      throw error
    }
  }

  async login(credentials) {
    if (!credentials?.email || !credentials?.password) {
      throw new ApiError(
        'Email and password are required',
        ErrorTypes.VALIDATION,
        422,
        { errors: ['Email and password are required'] }
      )
    }

    return await this.fetchInstance.makeRequest('post', '/users/sign_in', {
      user: {
        email: credentials.email,
        password: credentials.password,
        remember_me: credentials.remember
      }
    })
  }

  async initiateGoogleAuth() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
    
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/users/auth/google_oauth2';
    form.style.display = 'none';
    
    if (csrfToken) {
      const csrfInput = document.createElement('input');
      csrfInput.type = 'hidden';
      csrfInput.name = 'authenticity_token';
      csrfInput.value = csrfToken;
      form.appendChild(csrfInput);
    }
    
    document.body.appendChild(form);
    form.submit();
    
    return { success: true };
  }

  async verifyOAuthCallback(params) {
    try {
      return await this.fetchInstance.makeRequest('post', '/api/auth/verify_oauth', { params })
    } catch (error) {
      throw error
    }
  }

  async register(userData) {
    if (!userData?.username || !userData?.email || !userData?.password || !userData?.password_confirmation) {
      throw new ApiError(
        'All fields are required',
        ErrorTypes.VALIDATION,
        422,
        { errors: ['All fields are required'] }
      )
    }

    return await this.fetchInstance.makeRequest('post', '/users', {
      user: {
        username: userData.username,
        email: userData.email,
        password: userData.password,
        password_confirmation: userData.password_confirmation
      }
    })
  }

  async logout() {
    try {
      return await this.fetchInstance.makeRequest('delete', '/users/sign_out')
    } catch (error) {
      return { success: true }
    }
  }

  async updateProfile(userData) {
    if (!userData) {
      throw new ApiError(
        'Profile data is required',
        ErrorTypes.VALIDATION,
        422,
        { errors: ['Profile data is required'] }
      )
    }

    return await this.fetchInstance.makeRequest('patch', '/api/users/profile', {
      user: userData
    })
  }
}

export const authApiService = new AuthApiService()