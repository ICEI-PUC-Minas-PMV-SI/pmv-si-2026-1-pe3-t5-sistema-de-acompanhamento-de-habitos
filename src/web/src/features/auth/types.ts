export type UserRole = 'user' | 'moderator';

export type User = {
  id: string;
  name: string;
  email: string;
  password: string;
  role: UserRole;
  blocked?: boolean;
  createdAt: string;
};

export type Session = { userId: string } | null;
