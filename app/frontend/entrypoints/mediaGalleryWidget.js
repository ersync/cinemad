// const {onMounted, ref} = Vue
// import {useMedia} from '../composables/useMedia'
//
// const DEFAULT_TAB = 'popular_media'
//
// export function mediaGalleryWidget(movieId) {
//   if (!movieId) {
//     console.error('Movie ID is required')
//     return null
//   }
//
//   const {
//     media,
//     iframeVideos,
//     activeTab,
//     fetchMedia,
//     turnToIframe
//   } = useMedia(movieId)
//
//   const error = ref(null)
//
//   onMounted(async () => {
//     try {
//       await fetchMedia(DEFAULT_TAB)
//     } catch (e) {
//       console.error('Failed to fetch initial media:', e)
//       error.value = 'Failed to load media'
//     }
//   })
//
//   return {
//     getMedia: fetchMedia,
//     media,
//     activeTab,
//     turnToIframe,
//     iframeVideos,
//     error
//   }
// }