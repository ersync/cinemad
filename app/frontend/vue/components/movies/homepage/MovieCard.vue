<template>
  <div class="w-[130px] sm:w-[150px] shrink-0">
    <div class="relative">
      <div class="overflow-hidden rounded-lg min-h-[195px] sm:min-h-[225px] aspect-[2/3]">
        <a :href="moviePath">
          <img
              :src="movie.cover_url"
              :alt="movie.title"
              class="w-full h-full object-cover"
          />
        </a>
      </div>
      <AvgRateBadge
          :average-rating="movie.average_rating"
          class="absolute -bottom-5 left-3"
      />
    </div>
    <div class="pl-2 mt-6 sm:pl-2.5">
      <h3 class="font-SourceProBold text-sm sm:text-base leading-4 line-clamp-2">
        <a :href="moviePath">{{ movie.title }}</a>
      </h3>
      <span class="text-black/60 text-[0.7rem] sm:text-[0.9rem]">{{ formattedDate }}</span>
    </div>
  </div>
</template>

<script>
import AvgRateBadge from "@/vue/components/movies/shared/AvgRateBadge.vue"

export default {
  name: 'MovieCard',

  components: {
    AvgRateBadge,
  },

  props: {
    movie: {
      type: Object,
      required: true,
      validator: function(value) {
        return value.id && value.title && value.cover_url
      }
    }
  },

  computed: {
    moviePath() {
      return `/movies/${this.movie.slug}`
    },

    formattedDate() {
      if (!this.movie.release_date) return ''
      const date = new Date(this.movie.release_date)
      return date.toLocaleDateString('en-US', {
        month: 'short',
        day: 'numeric',
        year: 'numeric'
      })
    }
  }
}
</script>