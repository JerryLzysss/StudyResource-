import { Routes } from '@angular/router';
import { OverviewComponent } from './overview.component';

export const introRoutes: Routes = [
  { path: '', redirectTo: 'overview', pathMatch: 'full' },
  { path: 'overview', component: OverviewComponent },
];
