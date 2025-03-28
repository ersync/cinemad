import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from "vite-plugin-full-reload"
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import { ViteImageOptimizer } from 'vite-plugin-image-optimizer'
import { splitVendorChunkPlugin } from 'vite'

export default defineConfig({
    clearScreen: false,
    plugins: [
        RubyPlugin(),
        FullReload(["config/routes.rb", "app/views/**/*"], { delay: 200 }),
        vue(),
        splitVendorChunkPlugin(),
        ViteImageOptimizer({
            jpg: {
                quality: 90,
                progressive: true,
            },
            png: {
                quality: 90,
                progressive: true,
            },
            webp: {
                quality: 90,
                lossless: false,
            }
        })
    ],
    root: "./app/frontend",
    build: {
        manifest: true,
        rollupOptions: {
            input: {
                main: resolve(__dirname, 'app/frontend/entrypoints/application.js'),
                style: resolve(__dirname, 'app/frontend/styles/application.scss'),
            },
            output: {
                manualChunks: {
                    'vue-vendor': ['vue', 'vue-router', 'pinia'],
                },
                chunkFileNames: 'assets/js/[name]-[hash].js',
                entryFileNames: 'assets/js/[name]-[hash].js',
                assetFileNames: 'assets/[ext]/[name]-[hash].[ext]'
            }
        },
        sourcemap: true,
        minify: 'esbuild',
        assetsInlineLimit: 4096,
        chunkSizeWarningLimit: 1000
    },
    resolve: {
        alias: {
            '@': resolve(__dirname, 'app/frontend'),
        },
    },
    optimizeDeps: {
        include: ['vue', 'vue-router', 'pinia'],
    }
})