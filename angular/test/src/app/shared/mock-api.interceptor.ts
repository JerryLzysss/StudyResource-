import { HttpInterceptorFn, HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { delay, of, throwError } from 'rxjs';

const MOCK_USERS = [
  { id: 1, name: 'Angular 用户 A', email: 'a@example.com' },
  { id: 2, name: 'Angular 用户 B', email: 'b@example.com' },
  { id: 3, name: 'Angular 用户 C', email: 'c@example.com' },
];

export const mockApiInterceptor: HttpInterceptorFn = (req, next) => {
  if (!req.url.startsWith('/api/')) {
    return next(req);
  }

  const shouldFail = req.headers.get('X-Mock-Error') === 'true';
  const latency = Number(req.headers.get('X-Mock-Delay') ?? 1200);

  if (shouldFail) {
    return throwError(
      () => new HttpErrorResponse({ status: 500, statusText: 'Server Error', url: req.url }),
    ).pipe(delay(latency));
  }

  if (req.url === '/api/users' && req.method === 'GET') {
    return of(new HttpResponse({ status: 200, body: MOCK_USERS })).pipe(delay(latency));
  }

  return of(new HttpResponse({ status: 404, body: { message: '未找到接口' } })).pipe(delay(300));
};
