<template>
  <div class="filter-section relative">
    <h2>Keywords</h2>

    <div class="relative">
      <input
        v-model="query"
        @input="debounceSearch"
        autocomplete="off"
        placeholder="Filter by keywords..."
        class="w-full py-2 px-3 pr-10 text-sm text-slate-700 rounded-lg border border-slate-300 focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 outline-none shadow-sm transition-all"
      />
      <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
        </svg>
      </div>
    </div>

    <div class="mt-2 min-h-[40px]">
      <span
        v-for="keyword in selectedKeywords"
        :key="keyword"
        class="inline-flex items-center px-2.5 py-1 bg-indigo-100 text-indigo-800 rounded-full text-xs font-medium mr-2 mb-2 transition-all duration-200 hover:bg-indigo-200"
      >
        {{ keyword }}
        <button
          @click="removeKeyword(keyword)"
          class="ml-1.5 text-indigo-500 hover:text-indigo-700 focus:outline-none"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
        </button>
      </span>
    </div>

    <ul
      v-if="keywords.length"
      v-click-outside="closeDropdown"
      class="absolute z-20 bg-white border border-slate-200 rounded-lg w-full py-1 mt-1 text-sm text-slate-700 shadow-lg max-h-[200px] overflow-y-auto"
    >
      <li
        v-for="keyword in keywords"
        :key="keyword"
        @click="selectKeyword(keyword)"
        class="px-3 py-2 hover:bg-indigo-50 cursor-pointer transition-colors"
        :class="{ 'bg-indigo-50': selectedKeywords.includes(keyword) }"
      >
        {{ keyword }}
      </li>
      <li v-if="keywords.length === 0" class="px-3 py-2 text-slate-500 italic">
        No keywords found
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import { movieApiService } from '@/services/movieApiService'
import { debounce } from 'lodash'

const props = defineProps(['modelValue'])
const emit = defineEmits(['update:modelValue'])

const query = ref('')
const keywords = ref([])
const selectedKeywords = ref(props.modelValue ? (Array.isArray(props.modelValue) ? props.modelValue : [props.modelValue]) : [])

const debounceSearch = debounce(() => {
  searchKeywords()
}, 300)

const selectKeyword = (keyword) => {
  if (!selectedKeywords.value.includes(keyword)) {
    selectedKeywords.value.push(keyword)
    emit('update:modelValue', selectedKeywords.value)
  }
  query.value = ''
  keywords.value = []
}

const removeKeyword = (keyword) => {
  selectedKeywords.value = selectedKeywords.value.filter(k => k !== keyword)
  emit('update:modelValue', selectedKeywords.value)
}

const closeDropdown = () => {
  keywords.value = []
}

const vClickOutside = {
  mounted(el, binding) {
    el.clickOutsideEvent = (event) => {
      if (!(el === event.target || el.contains(event.target))) {
        binding.value()
      }
    }
    document.addEventListener('click', el.clickOutsideEvent)
  },
  unmounted(el) {
    document.removeEventListener('click', el.clickOutsideEvent)
  }
}

const searchKeywords = async () => {
  if (query.value.length > 2) {
    try {
      keywords.value = await movieApiService.searchKeywords(query.value)
    } catch (error) {
      console.error('Error searching keywords:', error)
      keywords.value = []
    }
  } else {
    keywords.value = []
  }
}
</script>