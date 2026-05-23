import type { Config } from 'tailwindcss';
import { SAH } from './src/tokens/sah';

export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: SAH.colors,
      borderRadius: SAH.radius,
      boxShadow: SAH.shadow,
      fontFamily: {
        display: SAH.font.display.split(',').map((s) => s.trim()),
        body: SAH.font.body.split(',').map((s) => s.trim()),
        mono: SAH.font.mono.split(',').map((s) => s.trim()),
      },
      keyframes: {
        'sah-bounce-in': {
          '0%': { transform: 'scale(.8)', opacity: '0' },
          '60%': { transform: 'scale(1.05)', opacity: '1' },
          '100%': { transform: 'scale(1)' },
        },
        'sah-slide-up': {
          from: { transform: 'translateY(8px)', opacity: '0' },
          to: { transform: 'translateY(0)', opacity: '1' },
        },
      },
      animation: {
        'bounce-in': 'sah-bounce-in 280ms ease-out',
        'slide-up': 'sah-slide-up 220ms ease-out',
      },
    },
  },
} satisfies Config;
