import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { APP_NAV, NavItem } from '../shared/nav.model';

@Component({
  selector: 'app-doc-layout',
  imports: [RouterOutlet, RouterLink, RouterLinkActive],
  templateUrl: './doc-layout.component.html',
  styleUrl: './doc-layout.component.css',
})
export class DocLayoutComponent {
  navItems: NavItem[] = APP_NAV;

  /** 将 'guide/signals' 转为 ['/guide', 'signals'] */
  linkTo(path: string): string[] {
    const [root, ...rest] = path.split('/');
    return ['/' + root, ...rest];
  }
}
