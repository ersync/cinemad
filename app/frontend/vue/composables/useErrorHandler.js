import {ref} from 'vue'

export function useErrorHandler(toast) {
  const error = ref(null)

  const handleError = (err, defaultMessage) => {
    console.error('Error occurred:', err)

    if (err.type) {
      switch (err.type) {
        case 'fetch':
          toast.warning(err.message, {timeout: 3000})
          break
        case 'update':
          toast.error(err.message, {timeout: 3000})
          break
        case 'unknown':
          toast.error(err.message, {timeout: 3000})
          break
        case 'critical':
          toast.error(err.message, {timeout: 0})
          break
        default:
          toast.error(defaultMessage || 'An unexpected error occurred. Please refresh the page.', {timeout: 3000})
      }
    } else {
      // For errors not coming from the store
      toast.error(defaultMessage || 'An unexpected error occurred. Please try again.', {timeout: 3000})
    }

    error.value = err
  }

  return {
    error,
    handleError
  }
}