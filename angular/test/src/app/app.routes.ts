import { Routes } from '@angular/router';
import { DocLayoutComponent } from './layout/doc-layout.component';

export const routes: Routes = [
  {
    path: '',
    component: DocLayoutComponent,
    children: [
      { path: '', redirectTo: 'intro/overview', pathMatch: 'full' },
      {
        path: 'intro',
        loadChildren: () => import('./intro/intro.routes').then(m => m.introRoutes),
      },
      {
        path: 'guide',
        loadChildren: () => import('./guide/guide.routes').then(m => m.guideRoutes),
      },
      {
        path: 'tools',
        loadChildren: () => import('./tools/tools.routes').then(m => m.toolsRoutes),
      },
    ],
  },
  { path: '**', redirectTo: 'intro/overview' },
];
