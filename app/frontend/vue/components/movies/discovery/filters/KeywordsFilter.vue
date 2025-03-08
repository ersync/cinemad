<template>
  <div class="filter-section relative">
    <h2 class="font-SourceProLight mb-2.5">Keywords</h2>

    <input
        v-model="query"
        @input="debounceSearch"
        autocomplete="off"
        placeholder="Filter by keywords..."
        class="block w-full py-1.5 px-2 text-[0.9rem] text-gray-500 rounded border border-gray-300 border-2 focus:border-tmdbLighterBlue focus:ring-tmdbLighterBlue outline-none"
    />

    <div class="mt-2">
      <span
          v-for="keyword in selectedKeywords"
          :key="keyword"
          class="inline-flex items-center px-2 py-1 bg-gray-200 text-gray-800 rounded-full text-sm mr-2 mb-2"
      >
        {{ keyword }}
        <button
            @click="removeKeyword(keyword)"
            class="ml-2 text-gray-500 hover:text-gray-700"
        >
          ×
        </button>
      </span>
    </div>

    <ul
        v-if="keywords.length"
        v-click-outside="closeDropdown"
        class="absolute top-[84px] border-t-0 z-10 bg-white border border-gray-300 w-full px-2 py-2 mt-1 text-[0.8rem] text-black/80"
    >
      <li
          v-for="keyword in keywords"
          :key="keyword"
          @click="selectKeyword(keyword)"
          class="px-2 py-1 hover:bg-gray-100 cursor-pointer"
          :class="{ 'bg-gray-100': selectedKeywords.includes(keyword) }"
      >
        {{ keyword }}
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
const selectedKeywords = ref(props.modelValue || [])

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