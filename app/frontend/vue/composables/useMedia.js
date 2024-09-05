const {ref} = Vue
import {getMedia} from '../services/api'

export function useMedia(movieId) {
  const media = ref({})
  const iframeVideos = ref([])
  const activeTab = ref('popular_media')

  const fetchMedia = async (mediaType) => {
    try {
      const response = await getMedia(movieId, mediaType)
      media.value.urls = response.urls
      activeTab.value = mediaType
      iframeVideos.value = []
    } catch (error) {
      console.error('Error fetching media:', error)
    } finally {
      resetScrollPosition()
    }
  }

  const turnToIframe = (index) => {
    if (!iframeVideos.value.includes(index)) {
      iframeVideos.value.push(index)
    }
  }

  const resetScrollPosition = () => {
    document.querySelectorAll(".scrollable-wrapper").forEach(el => el.scrollLeft = 0)
  }

  return {
    media,
    iframeVideos,
    activeTab,
    fetchMedia,
    turnToIframe
  }
}