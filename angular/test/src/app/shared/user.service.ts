import { Injectable, signal } from '@angular/core';

export interface User {
  id: number;
  name: string;
  role: string;
}

@Injectable({ providedIn: 'root' })
export class UserService {
  private readonly _users = signal<User[]>([
    { id: 1, name: '张三', role: '开发者' },
    { id: 2, name: '李四', role: '设计师' },
    { id: 3, name: '王五', role: '产品经理' },
  ]);

  readonly users = this._users.asReadonly();

  getById(id: number): User | undefined {
    return this._users().find((u) => u.id === id);
  }

  addUser(name: string, role: string): void {
    const nextId = Math.max(...this._users().map((u) => u.id), 0) + 1;
    this._users.update((list) => [...list, { id: nextId, name, role }]);
  }
}
