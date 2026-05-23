import { SAH } from '@/tokens/sah';

type Cell = { date: string; count: number };

type Props = {
  cells: Cell[];      // ordenado, em sequência de dias
  columns: number;    // ex: 7 (dia da semana) ou 5 (semanas)
  maxCount?: number;
};

export function Heatmap({ cells, columns, maxCount }: Props) {
  const max = maxCount ?? Math.max(1, ...cells.map((c) => c.count));
  const SIZE = 14;
  const GAP = 3;
  const rows = Math.ceil(cells.length / columns);

  const width = columns * (SIZE + GAP) - GAP;
  const height = rows * (SIZE + GAP) - GAP;

  return (
    <svg width="100%" viewBox={`0 0 ${width} ${height}`} role="img" aria-label="Mapa de check-ins">
      {cells.map((c, idx) => {
        const col = idx % columns;
        const row = Math.floor(idx / columns);
        const intensity = c.count / max;
        const fill = intensity === 0
          ? SAH.colors.surfaceAlt
          : tint(SAH.colors.primary, 0.2 + intensity * 0.8);
        return (
          <rect key={c.date}
            x={col * (SIZE + GAP)} y={row * (SIZE + GAP)}
            width={SIZE} height={SIZE}
            rx={3}
            fill={fill}>
            <title>{c.date}: {c.count} check-in{c.count === 1 ? '' : 's'}</title>
          </rect>
        );
      })}
    </svg>
  );
}

function tint(hex: string, alpha: number): string {
  // converte #RRGGBB → rgba(r,g,b,a)
  const r = parseInt(hex.slice(1, 3), 16);
  const g = parseInt(hex.slice(3, 5), 16);
  const b = parseInt(hex.slice(5, 7), 16);
  return `rgba(${r},${g},${b},${alpha.toFixed(2)})`;
}

type BarProps = { value: number; max?: number; color?: string };

export function MiniBar({ value, max = 100, color = SAH.colors.primary }: BarProps) {
  const pct = Math.max(0, Math.min(100, (value / max) * 100));
  return (
    <div className="w-full h-1.5 bg-surfaceAlt rounded-full overflow-hidden">
      <div style={{ width: `${pct}%`, background: color }} className="h-full" />
    </div>
  );
}
