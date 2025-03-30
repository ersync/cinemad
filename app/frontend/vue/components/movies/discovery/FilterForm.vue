<script setup>
import { ref } from "vue";
import FilterBox from "./FilterBox.vue";
import SortFilter from "./filters/SortFilter.vue";
import ShowMeFilter from "./filters/ShowMeFilter.vue";
import AvailabilitiesFilter from "./filters/AvailabilitiesFilter.vue";
import ReleaseFilter from "./filters/ReleaseFilter.vue";
import GenresFilter from "./filters/GenresFilter.vue";
import CertificationsFilter from "./filters/CertificationsFilter.vue";
import LanguageFilter from "./filters/LanguageFilter.vue";
import KeywordsFilter from "./filters/KeywordsFilter.vue";

const props = defineProps({
    initialFilters: {
        type: Object,
        required: true,
        default: () => ({
            sort: "popularity_desc",
            page: 1,
            per_page: 20,
            filter: {
                watch_status: "",
                availabilities: {},
                release_formats: [],
                date_from: "",
                date_to: "",
                genres: [],
                certifications: [],
                language: "",
                selected_keywords: "",
                all_availabilities: "0",
                all_release_formats: "0",
            },
        }),
    },
});

const emit = defineEmits(["search"]);

const sort = ref(props.initialFilters.sort || "");
const filters = ref({
    watch_status: "",
    availabilities: {},
    release_formats: {},
    date_from: "",
    date_to: "",
    genres: [],
    certifications: [],
    language: "",
    selected_keywords: "",
    all_availabilities: "0",
    all_release_formats: "0",
    ...(props.initialFilters.filter || {}),
});

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
            all_release_formats: filters.value.all_release_formats,
        },
    };

    emit("search", searchParams);
};
</script>

<template>
    <form
        @submit.prevent="handleSubmit"
        class="w-1/5 min-w-[280px] flex flex-col gap-3 select-none"
    >
        <FilterBox title="Sort">
            <SortFilter v-model="sort" />
        </FilterBox>

        <FilterBox title="Filters">
            <div class="space-y-6">
                <ShowMeFilter v-model="filters.watch_status" />
                <AvailabilitiesFilter
                    v-model:availabilities="filters.availabilities"
                    v-model:all="filters.all_availabilities"
                />
                <ReleaseFilter
                    v-model:formats="filters.release_formats"
                    v-model:dateFrom="filters.date_from"
                    v-model:dateTo="filters.date_to"
                />
                <GenresFilter v-model="filters.genres" />
                <CertificationsFilter v-model="filters.certifications" />
                <LanguageFilter v-model="filters.language" />
                <KeywordsFilter v-model="filters.selected_keywords" />
            </div>
        </FilterBox>

        <button
            type="submit"
            class="py-3 px-5 bg-gradient-to-r from-[#0a192f] to-[#112240] dark:from-indigo-600 dark:to-purple-700 text-white rounded-lg font-medium shadow-md hover:shadow-lg focus:ring-offset-2 focus:ring-[#233554] dark:focus:ring-indigo-500 transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]"
        >
            Apply Filters
        </button>
    </form>
</template>

<style>
.filter-section {
    @apply mb-4;
}

.filter-section h2 {
    @apply text-sm font-medium text-slate-500 dark:text-slate-400 mb-2.5;
}

.filter-tag {
    @apply px-3 py-1.5 rounded-full border border-slate-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-sm transition-all duration-200 hover:bg-slate-100 dark:hover:bg-gray-700 text-gray-800 dark:text-gray-200;
}

.form-select {
    @apply w-full rounded-md border-slate-300 dark:border-gray-600 bg-white dark:bg-gray-800 py-2 pl-3 pr-10 text-sm text-gray-900 dark:text-gray-100 focus:border-indigo-500 focus:ring-indigo-500;
}

.form-checkbox,
.form-radio {
    @apply rounded border-slate-300 dark:border-gray-600 text-indigo-600 focus:ring-indigo-500 w-4 h-4;
}
</style>
