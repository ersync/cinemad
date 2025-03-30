<template>
  <div class="relative">
    <label class="block text-xs sm:text-sm font-medium text-[#032541] dark:text-gray-300 mb-2">
      {{ label }}
    </label>
    <div class="relative">
      <input
          :value="modelValue"
          @input="$emit('update:modelValue', $event.target.value)"
          :type="type === 'password' ? (showPassword ? 'text' : 'password') : type"
          :required="required"
          :placeholder="placeholder"
          class="w-full px-3 py-2 sm:px-3 sm:py-2 rounded-xl border border-[#032541]/20 dark:border-gray-600 
               bg-white dark:bg-gray-700 text-[#202035] dark:text-gray-200 text-sm sm:text-base
               placeholder-[#032541]/40 dark:placeholder-gray-400 focus:border-[#032541]/40 dark:focus:border-gray-500 focus:outline-none
               transition-all duration-200"
      />
      <button
          v-if="type === 'password'"
          @click.prevent="togglePassword"
          type="button"
          class="absolute inset-y-0 right-0 pr-3 flex items-center text-[#032541]/40 dark:text-gray-400"
      >
        <svg v-if="showPassword" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
        </svg>
        <svg v-else class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
        </svg>
      </button>
    </div>

    <div v-if="type === 'password' && modelValue && showStrength"
         class="mt-1 flex items-center space-x-2">
      <div class="flex-1 flex gap-1">
        <div v-for="level in 4" :key="level"
             class="h-0.5 flex-1 rounded-full transition-all duration-300"
             :class="getStrengthBarClass(level)">
        </div>
      </div>
      <span class="text-xs" :class="strengthTextClass">
        {{ strengthText }}
      </span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  label: String,
  modelValue: String,
  type: { type: String, default: 'text' },
  required: { type: Boolean, default: false },
  placeholder: String,
  showStrength: { type: Boolean, default: false }
})

defineEmits(['update:modelValue'])

const showPassword = ref(false)

function togglePassword() {
  showPassword.value = !showPassword.value
}

const passwordStrength = computed(() => {
  if (!props.modelValue) return 0

  let score = 0
  const password = props.modelValue

  if (password.length >= 8) score++
  if (password.length >= 12) score++

  if (/[A-Z]/.test(password)) score++
  if (/[0-9]/.test(password)) score++
  if (/[^A-Za-z0-9]/.test(password)) score++

  return Math.min(score, 4)
})

const strengthText = computed(() => {
  const strength = passwordStrength.value
  return ['Very Weak', 'Weak', 'Medium', 'Strong', 'Very Strong'][strength]
})

const strengthTextClass = computed(() => {
  const classes = {
    0: 'text-pink-600 dark:text-pink-500',
    1: 'text-pink-400 dark:text-pink-400',
    2: 'text-yellow-600 dark:text-yellow-500',
    3: 'text-green-500',
    4: 'text-green-700 dark:text-green-500'
  }
  return classes[passwordStrength.value]
})

function getStrengthBarClass(level) {
  const strength = passwordStrength.value
  const baseClass = 'bg-gray-200 dark:bg-gray-600'
  const activeClasses = {
    1: 'bg-red-500',
    2: 'bg-yellow-500',
    3: 'bg-green-500',
    4: 'bg-green-600'
  }
  return level <= strength ? activeClasses[strength] : baseClass
}
</script>