import { Directive, ElementRef, input, effect } from '@angular/core';

@Directive({
  selector: '[appHighlight]',
})
export class HighlightDirective {
  appHighlight = input('#fff3cd');

  constructor(private el: ElementRef<HTMLElement>) {
    effect(() => {
      this.el.nativeElement.style.backgroundColor = this.appHighlight();
      this.el.nativeElement.style.transition = 'background-color 0.3s';
    });
  }
}
