/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/frontend/components/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        "tmdbDarkBlue": "#032541"
      },
      fontFamily: {
        SourceProLight: "SourcePro-Light",
        SourceProNormal: "SourcePro-Normal",
        SourceProItalic: "SourcePro-Italic",
        SourceProSemiBold: "SourcePro-SemiBold",
        SourceProBold: "SourcePro-Bold"
      },
      container: {
        center: true,

      }
    },
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1320px',
    }
  },
  plugins: [],
}

