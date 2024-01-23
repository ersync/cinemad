/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/views/**/*.{html,html.erb,erb}',
    './app/frontend/**/*.js',
  ],
  theme: {
    extend: {
      colors: {
        "tmdbLightBlue": "#120244",
        "tmdbLighterBlue": "#01b4e4",
        "tmdbDarkBlue": "#032541",
        "tmdbDarkerBlue": "#1c1c30",
        "tmdbPrimaryColor": "#202035",
        // "tmdbDarkerBlue": "#1f1f34",
        "tmdbLightGray": "#e3e3e3",
        "tmdbDarkGray": "#212529",
        "tmdbHoverGray": "#f8f9fa",

      },
      fontFamily: {
        SourceProLight: "SourcePro-Light",
        SourceProNormal: "SourcePro-Normal",
        SourceProItalic: "SourcePro-Italic",
        SourceProSemiBold: "SourcePro-SemiBold",
        SourceProBold: "SourcePro-Bold"
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
      addVariant('child', '& > *');
      addVariant('child-hover', '& > *:hover');
      addVariant('last-child-p', '& > p:last-of-type');
    }
  ],
}

