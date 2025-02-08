import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'


export default defineConfig({
  plugins: [vue()],
  server: {
    allowedHosts: ["9441-185-193-51-54.ngrok-free.app"]
  }
})
