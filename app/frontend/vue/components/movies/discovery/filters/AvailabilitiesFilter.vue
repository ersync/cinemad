<template>
    <div class="filter-section">
        <h2>Availabilities</h2>
        <div class="flex flex-wrap gap-2">
            <label
                v-for="option in availabilityOptions"
                :key="option"
                class="relative inline-flex items-center cursor-pointer"
            >
                <input
                    type="checkbox"
                    :value="option"
                    v-model="selectedAvailabilities"
                    @change="handleAvailabilityChange"
                    class="peer sr-only"
                />
                <span
                    class="filter-tag peer-checked:bg-indigo-600 dark:peer-checked:bg-indigo-500 peer-checked:border-indigo-600 dark:peer-checked:border-indigo-500 peer-checked:text-white"
                >
                    <span class="flex items-center">
                        <svg
                            v-if="selectedAvailabilities.includes(option)"
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-3.5 w-3.5 mr-1"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                clip-rule="evenodd"
                            />
                        </svg>
                        {{ option }}
                    </span>
                </span>
            </label>
        </div>
    </div>
</template>

<script setup>
import { ref, watch } from "vue";

const props = defineProps({
    availabilities: {
        type: Object,
        default: () => ({}),
    },
    all: {
        type: String,
        default: "0",
    },
});

const emit = defineEmits(["update:availabilities", "update:all"]);

const selectedAvailabilities = ref([]);

const availabilityOptions = ["Stream", "Free", "Ads", "Rent", "Buy"];

const handleAvailabilityChange = () => {
    const availabilitiesObj = {};
    selectedAvailabilities.value.forEach((option) => {
        availabilitiesObj[option.toLowerCase()] = true;
    });
    emit("update:availabilities", availabilitiesObj);

    emit("update:all", selectedAvailabilities.value.length === 0 ? "1" : "0");
};

watch(
    () => props.availabilities,
    (newValue) => {
        selectedAvailabilities.value = Object.entries(newValue)
            .filter(([_, value]) => value)
            .map(([key, _]) => key.charAt(0).toUpperCase() + key.slice(1));
    },
    { immediate: true },
);
</script>
