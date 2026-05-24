import clsx from 'clsx';
import type { SelectHTMLAttributes, Ref } from 'react';
import { forwardRef } from 'react';

type Option = { value: string; label: string };

type Props = SelectHTMLAttributes<HTMLSelectElement> & {
  options: Option[];
  invalid?: boolean;
};

export const Select = forwardRef(function Select(
  { options, invalid, className, ...rest }: Props,
  ref: Ref<HTMLSelectElement>,
) {
  return (
    <select
      ref={ref}
      {...rest}
      className={clsx(
        'bg-surface border rounded-md h-11 px-3 outline-none text-text',
        invalid ? 'border-danger' : 'border-border focus:border-primary',
        className,
      )}
    >
      {options.map((o) => (
        <option key={o.value} value={o.value}>{o.label}</option>
      ))}
    </select>
  );
});
