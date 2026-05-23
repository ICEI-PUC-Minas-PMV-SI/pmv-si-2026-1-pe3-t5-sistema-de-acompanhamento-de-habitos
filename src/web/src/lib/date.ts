const pad = (n: number) => n.toString().padStart(2, '0');

export function toDateKey(d: Date): string {
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
}

export function fromDateKey(key: string): Date {
  const [y, m, d] = key.split('-').map(Number);
  return new Date(y, m - 1, d);
}

export function todayKey(): string {
  return toDateKey(new Date());
}

export function addDays(d: Date, n: number): Date {
  const r = new Date(d);
  r.setDate(r.getDate() + n);
  return r;
}

export function startOfWeek(d: Date): Date {
  const r = new Date(d);
  r.setHours(0, 0, 0, 0);
  r.setDate(r.getDate() - r.getDay());
  return r;
}

export function weekKeysOf(d: Date): string[] {
  const start = startOfWeek(d);
  return Array.from({ length: 7 }, (_, i) => toDateKey(addDays(start, i)));
}

export function startOfMonth(d: Date): Date {
  return new Date(d.getFullYear(), d.getMonth(), 1);
}

export function monthKeysOf(d: Date): string[] {
  const start = startOfMonth(d);
  const end = new Date(d.getFullYear(), d.getMonth() + 1, 0).getDate();
  return Array.from({ length: end }, (_, i) => toDateKey(addDays(start, i)));
}

export function daysBetween(aKey: string, bKey: string): number {
  const a = fromDateKey(aKey).getTime();
  const b = fromDateKey(bKey).getTime();
  return Math.round((b - a) / 86_400_000);
}

export function weekdayIndex(key: string): number {
  return fromDateKey(key).getDay();
}
