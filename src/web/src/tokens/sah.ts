export const SAH = {
  colors: {
    bg: '#FAF7F2', bgAlt: '#F4F0E8',
    surface: '#FFFFFF', surfaceAlt: '#FBF8F3',
    border: 'rgba(60, 50, 40, 0.08)', borderStrong: 'rgba(60, 50, 40, 0.16)',
    text: '#2A2622', textMuted: '#6B655D', textFaint: '#9B958B',
    primary: '#4A7C59', primaryHover: '#3E6B4C',
    primarySoft: '#DCEAE0', primaryFaint: '#EEF5F0',
    accent: '#6B5B95', accentHover: '#584A7E',
    accentSoft: '#E5E0ED', accentFaint: '#F2EFF5',
    streak: '#C89B3C', streakSoft: '#F4E8CC',
    success: '#4A7C59', warning: '#C89B3C',
    danger: '#B8544A', dangerSoft: '#F2DAD7',
    info: '#5B7FA8', infoSoft: '#DCE5F0',
  },
  radius: { sm: '6px', md: '10px', lg: '14px', xl: '20px', full: '999px' },
  shadow: {
    sm: '0 1px 2px rgba(40,30,20,.04), 0 1px 3px rgba(40,30,20,.06)',
    md: '0 2px 4px rgba(40,30,20,.04), 0 8px 24px rgba(40,30,20,.08)',
    lg: '0 4px 8px rgba(40,30,20,.06), 0 16px 48px rgba(40,30,20,.12)',
    focus: '0 0 0 3px rgba(74,124,89,.2)',
  },
  font: {
    display: '"General Sans", "Inter Tight", -apple-system, sans-serif',
    body: '"Inter Tight", -apple-system, "Segoe UI", sans-serif',
    mono: '"JetBrains Mono", ui-monospace, monospace',
  },
} as const;

export type SAHColor = keyof typeof SAH.colors;
