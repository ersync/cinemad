<template>
  <div class="w-[150px] shrink-0">
    <div class="relative">
      <div class="absolute right-1.5 top-1.5   opacity-50">
        <svg class="w-[26px] h-[26px]">
          <use xlink:href="#circle-more"></use>
        </svg>
      </div>
      <div class="overflow-hidden rounded-lg">
        <a :href="moviePath">
          <img
              v-bind:src="movie.cover_url"
              class="h-[225px]"
              v-bind:alt="movie.title"
          />
        </a>
      </div>
      <AvgRateBadge
          :movie="{
          id: movie.id,
          average_rating: movie.average_rating
        }"
          class="absolute -bottom-5 left-3"
      />
    </div>
    <div class="pl-2.5 mt-6">
      <h3 class="font-SourceProBold leading-4 line-clamp-2">
        <a :href="moviePath">{{ movie.title }}</a>
      </h3>
      <span class="text-black/60 text-[0.9rem]">{{ formattedDate }}</span>
    </div>
  </div>
</template>

<script>
import AvgRateBadge from "@/vue/components/movies/show/AvgRateBadge.vue"

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
      return `/movies/${this.movie.id}`
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