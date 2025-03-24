import {defineConfig} from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from "vite-plugin-full-reload";
import vue from '@vitejs/plugin-vue'
import {resolve} from 'path'

export default defineConfig({
    clearScreen: false,
    plugins: [
        RubyPlugin(),
        FullReload(["config/routes.rb", "app/views/**/*"], {delay: 200}),
        vue()
    ],
    root: "./app/frontend",
    build: {
        manifest: true,
        rollupOptions: {
            input: {
                main: resolve(__dirname, 'app/frontend/entrypoints/application.js')
              }
        }
    },
    resolve: {
        alias: {
            '@': resolve(__dirname, 'app/frontend'),
        },
    },

})