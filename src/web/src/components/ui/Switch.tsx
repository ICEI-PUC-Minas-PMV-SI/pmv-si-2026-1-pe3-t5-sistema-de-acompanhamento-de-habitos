import clsx from 'clsx';

type Props = {
  checked: boolean;
  onChange: (v: boolean) => void;
  label?: string;
  id?: string;
};

export function Switch({ checked, onChange, label, id }: Props) {
  return (
    <label htmlFor={id} className="inline-flex items-center gap-2 cursor-pointer">
      <span className="sr-only">{label}</span>
      <button
        id={id}
        type="button"
        role="switch"
        aria-checked={checked}
        onClick={() => onChange(!checked)}
        className={clsx(
          'relative w-11 h-6 rounded-full transition-colors',
          checked ? 'bg-primary' : 'bg-borderStrong',
        )}
      >
        <span className={clsx(
          'absolute top-0.5 left-0.5 w-5 h-5 bg-surface rounded-full transition-transform shadow-sm',
          checked && 'translate-x-5',
        )} />
      </button>
      {label && <span className="text-sm text-text">{label}</span>}
    </label>
  );
}
