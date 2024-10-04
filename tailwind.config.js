/** @type {import('tailwindcss').Config} */
module.exports = {
  mode: 'jit',
  darkMode: 'class',
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/frontend/**/*.js',
    './app/frontend/**/*.vue',
  ],
  theme: {
    extend: {
      spacing: {
        "7.5": "1.875rem",
        "12.5": "3.125rem",
        "9.5": "2.375rem"
      },
      colors: {
        "tmdbPrimaryColor": "#202035",
        "tmdbDarkerBlue": "#1c1c30",
        "tmdbDarkBlue": "#032541",
        "tmdbLightBlue": "#120244",
        "tmdbLighterBlue": "#01b4e4",
        "tmdbLightGray": "#e3e3e3",
        "tmdbDarkGray": "#212529",
        "tmdbHoverGray": "#f8f9fa",
        "tmdbHoverGray": "#f8f9fa",
        "tmdbLightGreen": "#1ed5a9",


      },
      fontFamily: {
        SourceProLight: "SourcePro-Light",
        SourceProNormal: "SourcePro-Normal",
        SourceProItalic: "SourcePro-Italic",
        SourceProSemiBold: "SourcePro-SemiBold",
        SourceProBold: "SourcePro-Bold",
        ConcenBold: "Concen-Bold"
      },
      container: {
        padding: "1rem",
        center: true,

      }
    },
    screens: {
      // 'xs': '480px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1320px',
    },
    boxShadow: {
      "light": "0 2px 8px rgba(0,0,0,.1)",
      "medium": "0px 2px 8px 0px rgba(99, 99, 99, 0.2)"
    }
  },
  plugins: [
    function ({addVariant}) {
      addVariant('child', '& > *')
      addVariant('child-hover', '& > *:hover')
      addVariant('last-child-p', '& > p:last-of-type')
    },
  ],
}

