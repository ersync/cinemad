<template>
  <div
      class="flex flex-col justify-center sm:hidden w-full h-16 px-5 bg-tmdbDarkBlue font-SourceProSemiBold text-white">
    <!--mobile nav-->
    <div class="flex justify-between items-center">
      <!--mobile nav button-->
      <div class="mobile-nav-btn w-[62px]">
        <svg class="w-6 h-6 cursor-pointer font-semibold">
          <use xlink:href="#bars"></use>
        </svg>
      </div>
      <!--logo-->
      <div class="w-14 h-10 leading-10 select-none">
        <img class="inline-block"
             src="https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg"
             alt="">
      </div>
      <!--user profile-->
      <div class="flex justify-between gap-x-3.5">
        <div class="mobile-nav-btn">
          <!--          <%= link_to(current_user.present? ? user_profile_path(current_user) : new_user_session_path) do %>-->
          <svg class="w-6 h-6 cursor-pointer text-white">
            <use xlink:href="#user-profile"></use>
          </svg>
          <!--          <% end %>-->
        </div>
        <div class="mobile-nav-btn">
          <svg class="w-6 h-6 cursor-pointer text-white">
            <use xlink:href="#search"></use>
          </svg>
        </div>
      </div>
    </div>
    <!--mobile menu-->
    <div
        class="mobile-menu w-[80%] min-h-screen fixed z-50 top-16 -left-[80%] bottom-0 p-5 bg-tmdbDarkBlue/90 backdrop-blur-[8px] transition-all z-50 select-none overflow-y-scroll">
      <div class="overflow-y-scroll">
        <ul class="space-y-2.5">
          <li>
            <div class="flex items-center gap-2">
              <svg class="w-3 h-3">
                <use xlink:href="#movie"></use>
              </svg>
              <span class="category-movies inline-block font-SourceProSemiBold text-xl cursor-pointer">Movies</span>
            </div>
            <ul class="movies-submenu submenu font-SourceProNormal ml-5 child:mb-2.5 transition-all text-white/75">
              <li><a href="#">Popular</a></li>
              <li><a href="#">Top Rated</a></li>
              <li><a href="#">Upcoming</a></li>
              <li><a href="#">Now Playing</a></li>
            </ul>
          </li>
          <li>
            <div class="flex items-center gap-2">
              <svg class="w-3 h-3">
                <use xlink:href="#tv"></use>
              </svg>
              <span class="category-tv-shows inline-block font-SourceProSemiBold text-xl cursor-pointer">TV Shows</span>
            </div>
            <ul class="tv-shows-submenu submenu font-SourceProNormal ml-5 child:mb-2.5 transition-all text-white/75">
              <li><a href="#">Popular</a></li>
              <li><a href="#">Top Rated</a></li>
              <li><a href="#">Upcoming</a></li>
              <li><a href="#">Now Playing</a></li>
            </ul>
          </li>
          <li>
            <div class="flex items-center gap-2">
              <svg class="w-3 h-3">
                <use xlink:href="#people"></use>
              </svg>
              <span class="category-people inline-block font-SourceProSemiBold text-xl cursor-pointer">People</span>
            </div>
            <ul class="people-submenu submenu font-SourceProNormal ml-5 child:mb-2.5 transition-all text-white/75">
              <li><a href="#">Popular</a></li>
              <li><a href="#">Top Rated</a></li>
              <li><a href="#">Upcoming</a></li>
              <li><a href="#">Now Playing</a></li>
            </ul>
          </li>
        </ul>
        <ul class="font-SourceProSemiBold text-white/60 space-y-2.5 mt-7">
          <li><a href="">Contribution Bible</a></li>
          <li><a href="">Discussions</a></li>
          <li><a href="">Leaderboard</a></li>
          <li><a href="">API</a></li>
          <li><a href="">Support</a></li>
          <li><a href="">About</a></li>
        </ul>
        <div class="w-60 h-px bg-white/10 rounded-lg my-7"></div>
        <div class="font-SourceProSemiBold flex justify-start items-center gap-4 mb-16">
          <!--          <%= link_to "Sign In", new_user_registration_path, class: "w-28 h-10 rounded-lg overflow-hidden border-1-->
          <!--          border-gray-200-->
          <!--          text-gray-200 shadow-light text-tmdbDarkBlue text-center leading-[40px]"-->
          <!--          %>-->
          <!--          <%= link_to "Join TMDB", new_user_registration_path, class: "w-28 h-10 rounded-lg overflow-hidden border-1-->
          <!--          border-gray-100 bg-white/90 shadow-light text-tmdbDarkBlue text-center leading-[40px]"-->
          <!--          %>-->
        </div>
      </div>
    </div>
  </div>

</template>

<script>
export default {
  mounted() {
    console.log('Component mounted')

    const elements2 = {
      mobileNavBtn: document.querySelector(".mobile-nav-btn"),
      mobileMenuCloseBtn: document.querySelector(".mobile-close-btn"),
      overlay: document.querySelector(".overlay"),
      mobileMenu: document.querySelector(".mobile-menu"),
      categoryMovies: document.querySelector('.category-movies'),
      categoryTvShows: document.querySelector('.category-tv-shows'),
      categoryPeople: document.querySelector('.category-people'),
      moviesSubmenu: document.querySelector(".movies-submenu"),
      tvShowsSubmenu: document.querySelector(".tv-shows-submenu"),
      peopleSubmenu: document.querySelector(".people-submenu"),
    }

    // Check if elements exist
    if (!elements2.mobileNavBtn || !elements2.mobileMenu || !elements2.categoryMovies) {
      console.error("Required elements not found")
      return
    }

    function toggleMenu() {
      if (elements2.overlay) {
        console.log("fook")
        elements2.overlay.classList.toggle("overlay--visible")
      }
      elements2.mobileMenu.classList.toggle("-left-[80%]")
      elements2.mobileMenu.classList.toggle("left-0")
    }

    function toggleSubmenu(submenu) {
      submenu.classList.toggle("submenu--open")
    }

    elements2.mobileNavBtn.addEventListener("click", toggleMenu)

    if (elements2.overlay) {
      elements2.overlay.addEventListener("click", toggleMenu)
    }

    elements2.categoryMovies.addEventListener("click", () => toggleSubmenu(elements2.moviesSubmenu))
    elements2.categoryTvShows.addEventListener("click", () => toggleSubmenu(elements2.tvShowsSubmenu))
    elements2.categoryPeople.addEventListener("click", () => toggleSubmenu(elements2.peopleSubmenu))
  }
}
</script>

<style scoped>
h1 {
  font-family: Arial, sans-serif;
}
</style>
