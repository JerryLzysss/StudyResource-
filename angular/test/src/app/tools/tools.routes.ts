import { Routes } from '@angular/router';
import { CliDemoComponent } from './cli/cli-demo.component';
import { LibrariesDemoComponent } from './libraries/libraries-demo.component';
import { DevtoolsDemoComponent } from './devtools/devtools-demo.component';
import { LanguageServiceDemoComponent } from './language-service/language-service-demo.component';

export const toolsRoutes: Routes = [
  { path: '', redirectTo: 'cli', pathMatch: 'full' },
  { path: 'cli', component: CliDemoComponent },
  { path: 'libraries', component: LibrariesDemoComponent },
  { path: 'devtools', component: DevtoolsDemoComponent },
  { path: 'language-service', component: LanguageServiceDemoComponent },
];
