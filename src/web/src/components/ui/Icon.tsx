export function Icon({ name, size = 20 }: { name: string; size?: number }) {
  // Para o protótipo usamos emoji direto — é o que o design system existente faz.
  return (
    <span style={{ fontSize: size, lineHeight: 1 }} aria-hidden="true">
      {name}
    </span>
  );
}
