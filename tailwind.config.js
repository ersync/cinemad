/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/frontend/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        "tmdbDarkBlue": "#032541",
        "tmdbHoverGray": "#f8f9fa"
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
  plugins: [
    function ({addVariant}) {
      addVariant('child', '& > *');
      addVariant('child-hover', '& > *:hover');
    }
  ],
}

