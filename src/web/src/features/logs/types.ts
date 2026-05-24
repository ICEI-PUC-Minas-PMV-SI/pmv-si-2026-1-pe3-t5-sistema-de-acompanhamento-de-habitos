export type LogType = 'auth' | 'habito' | 'moderacao' | 'sistema';

export type LogEntry = {
  id: string;
  type: LogType;
  message: string;
  userId?: string;
  createdAt: string;
};
