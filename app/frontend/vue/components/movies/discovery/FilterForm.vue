<template>
  <form @submit.prevent="handleSubmit" class="w-1/5 min-w-[260px] flex flex-col justify-start items-center child:w-full select-none">
    <FilterBox title="Sort">
      <SortFilter v-model="sort" />
    </FilterBox>

    <FilterBox title="Filters">
      <ShowMeFilter v-model="filters.watch_status" />
      <AvailabilitiesFilter
          v-model:availabilities="filters.availabilities"
          v-model:all="filters.all_availabilities"
      />
      <ReleaseFilter
          v-model:formats="filters.release_formats"
          v-model:all="filters.all_release_formats"
          v-model:dateFrom="filters.date_from"
          v-model:dateTo="filters.date_to"
      />
      <GenresFilter v-model="filters.genres" />
      <CertificationsFilter v-model="filters.certifications" />
      <LanguageFilter v-model="filters.language" />
      <KeywordsFilter v-model="filters.selected_keywords" />
    </FilterBox>

    <button type="submit" class="btn-primary">Search</button>
  </form>
</template>

<script setup>
import { ref } from 'vue'
import FilterBox from './FilterBox.vue'
import SortFilter from './filters/SortFilter.vue'
import ShowMeFilter from './filters/ShowMeFilter.vue'
import AvailabilitiesFilter from './filters/AvailabilitiesFilter.vue'
import ReleaseFilter from './filters/ReleaseFilter.vue'
import GenresFilter from './filters/GenresFilter.vue'
import CertificationsFilter from './filters/CertificationsFilter.vue'
import LanguageFilter from './filters/LanguageFilter.vue'
import KeywordsFilter from './filters/KeywordsFilter.vue'

const props = defineProps({
  initialFilters: {
    type: Object,
    required: true,
    default: () => ({
      sort: 'popularity_desc',
      page: 1,
      per_page: 20,
      filter: {
        watch_status: '',
        availabilities: {},
        release_formats: [],
        date_from: '',
        date_to: '',
        genres: [],
        certifications: [],
        language: '',
        selected_keywords: '',
        all_availabilities: '0',
        all_release_formats: '0'
      }
    })
  }
})

const emit = defineEmits(['search'])

const sort = ref(props.initialFilters.sort || '')
const filters = ref({
  watch_status: '',
  availabilities: {},
  release_formats: {},
  date_from: '',
  date_to: '',
  genres: [],
  certifications: [],
  language: '',
  selected_keywords: '',
  all_availabilities: '0',
  all_release_formats: '0',
  ...(props.initialFilters.filter || {})
})

const handleSubmit = () => {
  const searchParams = {
    sort: sort.value,
    filter: {
      watch_status: filters.value.watch_status,
      availabilities: filters.value.availabilities,
      release_formats: filters.value.release_formats,
      date_from: filters.value.date_from,
      date_to: filters.value.date_to,
      genres: filters.value.genres,
      certifications: filters.value.certifications,
      language: filters.value.language,
      selected_keywords: filters.value.selected_keywords,
      all_availabilities: filters.value.all_availabilities,
      all_release_formats: filters.value.all_release_formats
    }
  }

  emit('search', searchParams)
}
</script>