<template>
    <div class="relative group cursor-pointer h-full py-1">
        <div
            class="flex justify-center items-center w-[46px] h-[46px] bg-black rounded-full hover:scale-105 transition-all duration-300 ease-in-out"
            :class="{
                'border-2 border-amber-300/70 shadow-[0_0_12px_rgba(251,191,36,0.4)]': userRating,
                'border border-white/5': !userRating
            }"
        >
            <svg
                class="h-[18px] w-[18px] transition-transform duration-300"
                :class="{
                    'text-yellow-300 drop-shadow-[0_0_5px_rgba(251,191,36,0.8)] scale-110':
                        userRating,
                }"
            >
                <use xlink:href="#star"></use>
            </svg>

            <div
                v-if="!disabled"
                v-cloak
                class="fixed-width-rating-popup flex justify-center items-center absolute top-full mt-1 left-[100%] -translate-x-[55%] z-40 px-3 invisible opacity-0 group-hover:opacity-100 group-hover:visible transition-all duration-200 delay-75 gap-3 rounded-lg bg-gradient-to-br from-[#032541] to-[#021b2f] border border-blue-900/30 shadow-lg backdrop-filter backdrop-blur-sm text-white cursor-pointer"
            >
                <button
                    @click.prevent="unsetRate"
                    :disabled="!userRating"
                    class="flex items-center justify-center p-1.5 rounded-md hover:bg-[#021b2f] transition-colors duration-200"
                    :class="{
                        'opacity-50 cursor-not-allowed': !userRating,
                        'cursor-pointer': userRating,
                    }"
                    title="Remove your rating"
                >
                    <div class="flex flex-col items-center">
                        <svg class="w-4 h-4 mb-0.5">
                            <use xlink:href="#star"></use>
                        </svg>
                        <span class="text-[12px] font-medium">Unrate!</span>
                    </div>
                </button>

                <div ref="ratingContainerRef">
                    <span
                        @mousemove="setHoveredRateWidth"
                        @mouseleave="resetHoveredRateWidth"
                        class="relative inline-block flex justify-center items-center"
                    >

                        <a
                            :style="{ width: hoveredRateWidth }"
                            @click.prevent="setRate"
                            class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap my-auto child:inline-block overflow-hidden text-gray-100 mt-1.5"
                        >
                            <span v-for="index in 5" :key="`hover-${index}`">
                                <svg class="h-7 w-7">
                                    <use xlink:href="#star"></use>
                                </svg>
                            </span>
                        </a>

                        <a
                            :style="{ width: rateWidth }"
                            class="transition-all duration-100 absolute left-0 inline-block whitespace-nowrap my-auto child:inline-block overflow-hidden text-yellow-400 mt-1.5 pointer-events-none"
                        >
                            <span v-for="index in 5" :key="`rate-${index}`">
                                <svg class="h-7 w-7">
                                    <use xlink:href="#star"></use>
                                </svg>
                            </span>
                        </a>

                        <!-- Empty stars -->
                        <span v-for="index in 5" :key="`empty-${index}`">
                            <svg class="h-7 w-7 text-gray-300/80">
                                <use xlink:href="#star-empty"></use>
                            </svg>
                        </span>
                    </span>
                </div>

                <div
                    v-if="userRating"
                    class="rating-display flex items-center justify-center min-w-[40px]"
                >
                    <span class="text-yellow-400 font-medium whitespace-nowrap">
                        {{ userRating / 10 / 2 }}/5
                    </span>
                </div>
                <div
                    v-else
                    class="rating-display flex items-center justify-center min-w-[40px] opacity-0"
                >
                    <span class="text-transparent whitespace-nowrap">
                        0/5
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, watchEffect } from "vue";
import { useUserInteractionStore } from "@/vue/stores/userInteractionStore";
import { useToast } from "vue-toastification";
import { useErrorHandler } from "@/vue/composables/useErrorHandler";

const props = defineProps({
    disabled: {
        type: Boolean,
        default: false,
    },
    movieSlug: {
        type: String,
        required: true,
    },
});

const ratingSteps = [
    { startPercentage: 3, endPercentage: 10, rate: 10, width: "10%" },
    { startPercentage: 10, endPercentage: 23, rate: 20, width: "20%" },
    { startPercentage: 23, endPercentage: 30, rate: 30, width: "30%" },
    { startPercentage: 30, endPercentage: 44, rate: 40, width: "40%" },
    { startPercentage: 44, endPercentage: 53, rate: 50, width: "50%" },
    { startPercentage: 53, endPercentage: 64, rate: 60, width: "60%" },
    { startPercentage: 64, endPercentage: 75, rate: 70, width: "70%" },
    { startPercentage: 75, endPercentage: 86, rate: 80, width: "80%" },
    { startPercentage: 86, endPercentage: 95, rate: 90, width: "90%" },
    { startPercentage: 95, endPercentage: 105, rate: 100, width: "100%" },
];

const interactionStore = useUserInteractionStore();
const toast = useToast();
const { handleError } = useErrorHandler(toast);

const { userRating, error } = interactionStore.movieInteractionsComputed(
    props.movieSlug,
);

const rateWidth = computed(() => {
    return (
        ratingSteps.find((step) => step.rate === userRating.value)?.width || 0
    );
});

const hoveredRateWidth = ref(0);
const ratingContainerRef = ref(null);

const calculateCursorPosition = (event) => {
    if (!ratingContainerRef.value) return 0;

    const ratingContainerWidth = ratingContainerRef.value.offsetWidth;
    const mouseX =
        event.clientX - ratingContainerRef.value.getBoundingClientRect().left;
    return (mouseX / ratingContainerWidth) * 100;
};

const setRate = async (event) => {
    try {
        const cursorPosition = calculateCursorPosition(event);
        const newRate =
            ratingSteps.find(
                (ratingStep) =>
                    cursorPosition > ratingStep.startPercentage &&
                    cursorPosition < ratingStep.endPercentage,
            )?.rate || 0;

        const result = await interactionStore.setRate(
            props.movieSlug,
            parseInt(newRate),
        );
        if (!result.success) {
            throw new Error(result.error);
        }
        resetHoveredRateWidth();
    } catch (err) {
        handleError(err, "Failed to set rating. Please try again.");
    }
};

const unsetRate = async () => {
    try {
        const result = await interactionStore.unsetRate(props.movieSlug);
        if (!result.success) {
            throw new Error(result.error);
        }
        resetHoveredRateWidth();
    } catch (err) {
        handleError(err, "Failed to unset rating. Please try again.");
    }
};

const setHoveredRateWidth = (event) => {
    const cursorPosition = calculateCursorPosition(event);
    hoveredRateWidth.value =
        ratingSteps.find(
            (step) =>
                cursorPosition > step.startPercentage &&
                cursorPosition < step.endPercentage,
        )?.width || "0";
};

const resetHoveredRateWidth = () => {
    hoveredRateWidth.value = 0;
};

watchEffect(() => {
    if (error.value) {
        handleError(error.value);
    }
});
</script>

<style scoped>
.fixed-width-rating-popup {
    min-width: 220px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
}

.rating-display {
    transition: opacity 0.2s ease-in-out;
}

@media (hover: hover) {
    .group:hover .rating-display {
        opacity: 1;
    }
}
</style>
