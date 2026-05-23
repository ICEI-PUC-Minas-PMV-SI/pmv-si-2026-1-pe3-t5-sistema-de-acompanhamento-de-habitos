import { Button, Card, Badge, Logo } from '@/components/ui';

export default function App() {
  return (
    <div className="min-h-screen bg-bg p-6 space-y-4">
      <Logo size={40} withWordmark />
      <Card>
        <h2 className="font-display text-xl">Vitrine UI</h2>
        <div className="flex gap-2 mt-2">
          <Button>Primary</Button>
          <Button variant="secondary">Secondary</Button>
          <Button variant="ghost">Ghost</Button>
          <Button variant="danger">Danger</Button>
        </div>
        <div className="flex gap-2 mt-3">
          <Badge tone="primary">primary</Badge>
          <Badge tone="streak">🔥 12 dias</Badge>
          <Badge tone="accent">accent</Badge>
        </div>
      </Card>
    </div>
  );
}
