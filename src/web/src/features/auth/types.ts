export type User = {
  id: string;
  name: string;
  email: string;
  password: string;
  createdAt: string;
};

export type Session = { userId: string } | null;
