import { Component } from "@angular/core";

@Component({
    selector: 'todo-list-item',
    standalone: true,

    template: `<li>Title:{{taskTitle}}</li>
              <li>Finish:{{isComplete}}</li>
              <button type="submit" [disabled]="isInvalid">Submit</button>
             
    `,
    styles: `
      li{
      color:red;
      font-weight:300;
      }
    `
    //templateUrl:'xxx.html',允许将html分离
    //styleUrl:'xxx.css',允许将css分离
})
export class TodoListItem {
    taskTitle = '';
    isComplete = false;
    isInvalid = true;
   
    completeTask() {
        this.isComplete = true;
    }
    updateTitle(newTitle: string) {
        this.taskTitle = newTitle;
    }
}
