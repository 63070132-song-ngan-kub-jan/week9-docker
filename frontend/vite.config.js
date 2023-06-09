import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    port: 8081,
    host: true,
    strictPort: true,
  },
  plugins: [vue()],
});
