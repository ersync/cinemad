<template>
    <div
        class="relative w-[130px] md:w-[180px] overflow-hidden rounded-lg shadow-medium flex flex-col justify-between items-start"
    >
        <div class="relative">
            <div
                class="absolute right-1.5 top-1.5 opacity-50 hover:filter-blue-invert transition-all"
            >
                <svg
                    class="w-[21px] h-[21px] md:w-[26px] md:h-[26px] cursor-pointer"
                >
                    <use xlink:href="#circle-more"></use>
                </svg>
            </div>

            <div class="min-h-[195px] md:min-h-[270px]">
                <router-link
                    :to="{ name: 'movie-show', params: { slug: movie.slug } }"
                >
                    <img
                        :src="coverImage"
                        :alt="movie.title"
                        class="w-full h-full object-cover"
                        loading="lazy"
                        @error="handleImageError"
                    />
                </router-link>
            </div>

            <AvgRateBadge
                :average-rating="rating"
                size="small-chart"
                class="absolute bottom-[-16px] md:bottom-[-20px] left-2"
                :should-animate="false"
            />
        </div>

        <div class="h-[56px] md:h-[40px] mt-6 mb-1 px-2.5">
            <h2
                class="font-SourceProBold line-clamp-2 text-sm md:text-[1rem] leading-[20px] mb-0.5"
            >
                {{ movie.title }}
            </h2>
        </div>

        <div class="pb-2 px-2.5">
            <p class="text-black/60 text-[11px] md:text-[14px]">
                {{ releaseDate }}
            </p>
        </div>

        <span
            class="inline-block absolute bottom-[9px] right-[6px] text-gray-600 border border-gray-300 rounded text-[0.5rem] md:text-[0.7rem] px-1"
        >
            {{ ageRating }}
        </span>
    </div>
</template>

<script setup>
import { ref, computed } from "vue";
import AvgRateBadge from "@/vue/components/movies/shared/AvgRateBadge.vue";

const props = defineProps({
    movie: {
        type: Object,
        required: true,
        validator: (movie) => {
            return (
                movie &&
                typeof movie.slug === "string" &&
                typeof movie.title === "string"
            );
        },
    },
});

const defaultImagePath = "/assets/default-movie-poster.jpg";
const fallbackImage = ref(defaultImagePath);

const coverImage = computed(() => {
    return props.movie.cover_url || fallbackImage.value;
});

const releaseDate = computed(() => {
    if (!props.movie.release_date) return "TBA";

    try {
        return new Date(props.movie.release_date).toLocaleDateString("en-US", {
            month: "short",
            day: "numeric",
            year: "numeric",
        });
    } catch (error) {
        console.error("Invalid date format:", error);
        return "Release date TBA";
    }
});

const rating = computed(() => {
    return props.movie.average_rating ?? 0;
});

const ageRating = computed(() => {
    return props.movie.age_rating || "NR";
});

const handleImageError = (event) => {
    event.target.src = fallbackImage.value;
    event.target.alt = "Movie poster not available";
};
</script>

<style scoped>
.movie-card {
    transition: transform 0.2s ease-in-out;
}

.movie-card:hover {
    transform: scale(1.02);
}

.hover\:filter-blue-invert:hover {
    filter: brightness(1.2);
}

img {
    aspect-ratio: 2/3;
    object-fit: cover;
}

img {
    background: linear-gradient(110deg, #ececec 8%, #f5f5f5 18%, #ececec 33%);
    background-size: 200% 100%;
    animation: 1.5s shine linear infinite;
}

@keyframes shine {
    to {
        background-position-x: -200%;
    }
}
</style>
