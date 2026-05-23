import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'node:path';

export default defineConfig({
  plugins: [react()],
  base: process.env.NODE_ENV === 'production'
    ? '/pmv-si-2026-1-pe3-t5-sistema-de-acompanhamento-de-habitos/'
    : '/',
  resolve: {
    alias: { '@': path.resolve(__dirname, './src') },
  },
});
