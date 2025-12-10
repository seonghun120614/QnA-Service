import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',     // 도커 컨테이너 외부 접근 허용
    port: 5176,
    watch: {
      usePolling: true   // 도커 볼륨에서 파일 변경 감지
    },
    hmr: {
      host: 'localhost'  // HMR(Hot Module Replacement) 설정
    }
  }
})
