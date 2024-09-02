import NProgress from "nprogress"
import 'nprogress/nprogress.css'
import Fetch from "./fetch"

const {ref, onMounted} = Vue

export function setupApp2() {
  const media = ref({})
  const iframeVideos = ref([])
  const activeTab = ref('popular_media')
  const movieId = document.getElementById('app2').getAttribute('data-movie-id')

  const getMedia = async (mediaType) => {

    try {
      const response = await Fetch.get(`/movies/${movieId}/${mediaType}`)
      media.value.urls = response.urls
      activeTab.value = mediaType
      iframeVideos.value.length = 0


    } catch (error) {
      console.error('Error fetching media:', error)
    } finally {
      document.querySelectorAll(".scrollable-wrapper").forEach(el => el.scrollLeft = 0)
    }
  }

  const turnToIframe = (index) => {
    if (!iframeVideos.value.includes(index)) {
      iframeVideos.value.push(index)
    }
  }

  onMounted(() => {
    getMedia('popular_media')
  })
  return {
    getMedia,
    media,
    activeTab,
    turnToIframe,
    iframeVideos
  }
}