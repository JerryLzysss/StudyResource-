import { Routes } from '@angular/router';
import { SignalsDemoComponent } from './signals/signals-demo.component';
import { ComponentsDemoComponent } from './components/components-demo.component';
import { TemplatesDemoComponent } from './templates/templates-demo.component';
import { DirectivesDemoComponent } from './directives/directives-demo.component';
import { DiDemoComponent } from './dependency-injection/di-demo.component';
import { RoutingDemoComponent, RoutingDetailComponent } from './routing/routing-demo.component';
import { FormsDemoComponent } from './forms/forms-demo.component';
import { HttpDemoComponent } from './http-client/http-demo.component';
import { SsrDemoComponent } from './ssr/ssr-demo.component';
import { TestingDemoComponent } from './testing/testing-demo.component';
import { I18nDemoComponent } from './i18n/i18n-demo.component';
import { AnimationsDemoComponent } from './animations/animations-demo.component';
import { DragDropDemoComponent } from './drag-drop/drag-drop-demo.component';

export const guideRoutes: Routes = [
  { path: '', redirectTo: 'signals', pathMatch: 'full' },
  { path: 'signals', component: SignalsDemoComponent },
  { path: 'components', component: ComponentsDemoComponent },
  { path: 'templates', component: TemplatesDemoComponent },
  { path: 'directives', component: DirectivesDemoComponent },
  { path: 'dependency-injection', component: DiDemoComponent },
  {
    path: 'routing',
    component: RoutingDemoComponent,
    children: [{ path: 'detail/:id', component: RoutingDetailComponent }],
  },
  { path: 'forms', component: FormsDemoComponent },
  { path: 'http-client', component: HttpDemoComponent },
  { path: 'ssr', component: SsrDemoComponent },
  { path: 'testing', component: TestingDemoComponent },
  { path: 'i18n', component: I18nDemoComponent },
  { path: 'animations', component: AnimationsDemoComponent },
  { path: 'drag-drop', component: DragDropDemoComponent },
];
