import { defineStore } from 'pinia'

export const useLoadingStore = defineStore('loading', {
  state: () => ({
    isLoading: false,
    loadingQueue: 0
  }),
  actions: {
    startLoading() {
      this.loadingQueue++
      this.isLoading = true
    },
    stopLoading() {
      this.loadingQueue--
      if (this.loadingQueue <= 0) {
        this.loadingQueue = 0
        this.isLoading = false
      }
    }
  }
})