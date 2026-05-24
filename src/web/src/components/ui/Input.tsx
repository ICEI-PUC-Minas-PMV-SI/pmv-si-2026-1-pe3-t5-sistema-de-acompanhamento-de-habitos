import clsx from 'clsx';
import type { InputHTMLAttributes, ReactNode, Ref } from 'react';
import { forwardRef } from 'react';

type Props = InputHTMLAttributes<HTMLInputElement> & {
  prefix?: ReactNode;
  invalid?: boolean;
};

export const Input = forwardRef(function Input(
  { prefix, invalid, className, ...rest }: Props,
  ref: Ref<HTMLInputElement>,
) {
  return (
    <div className={clsx(
      'flex items-center gap-2 bg-surface border rounded-md h-11 px-3',
      invalid ? 'border-danger' : 'border-border focus-within:border-primary',
      className,
    )}>
      {prefix && <span className="text-textMuted">{prefix}</span>}
      <input
        ref={ref}
        {...rest}
        className="flex-1 bg-transparent outline-none placeholder:text-textFaint text-text"
      />
    </div>
  );
});
