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
        "tmdbDarkerBlue": "#1f1f34",
        "tmdbHoverGray": "#f8f9fa",
        "tmdbLightBlue": "#120244",
        "tmdbDarkGray": "#212529",
        "tmdbLightGray": "#e3e3e3",

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
      '2xs': '320px',
      'xs': '480px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1400px',
    },
    boxShadow: {
      "light": "0 2px 8px rgba(0,0,0,.1)"
    }
  },
  plugins: [
    function ({addVariant}) {
      addVariant('child', '& > *');
      addVariant('child-hover', '& > *:hover');
    }
  ],
}

