export function Logo({ size = 32, withWordmark = false }: { size?: number; withWordmark?: boolean }) {
  return (
    <div className="inline-flex items-center gap-2">
      <svg width={size} height={size} viewBox="0 0 32 32" aria-hidden="true">
        <rect width="32" height="32" rx="6" fill="#4A7C59" />
        <path d="M9 17l4 4 10-10" stroke="#FAF7F2" strokeWidth="3" fill="none"
          strokeLinecap="round" strokeLinejoin="round" />
      </svg>
      {withWordmark && (
        <span className="font-display font-semibold text-xl text-text">SAH</span>
      )}
    </div>
  );
}
