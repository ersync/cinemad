import {defineConfig} from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from "vite-plugin-full-reload";
import {resolve} from 'path'

export default defineConfig({
  clearScreen: false,
  plugins: [
    RubyPlugin(),
    FullReload(["config/routes.rb", "app/views/**/*"], {delay: 200})

  ],
  root: "./app/assets",
  build: {
    manifest: true,
    rollupOptions: {
      input: "/app/frontend/entrypoints/application.js"
    }
  },
  resolve: {
    alias: {
      '@assets': resolve(__dirname, 'app/assets'),
    },
  },

})