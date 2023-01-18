import { Controller } from '@hotwired/stimulus';

// Conditions on when to save the query to the database
export default class extends Controller {
  // Condition #1: Save query when user stops typing after 2.5 seconds.
  search() {
    let save = document.getElementById('save-input');
    save.value = false;
    this.element.requestSubmit();
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      save.value = true;
      this.element.requestSubmit();
    }, 2500);
  }

  // Condition #2: Save query if the user presses ENTER
  keyPress(event) {
    let save = document.getElementById('save-input');
    if (event.keyCode == 13) {
      save.value = true;
      this.element.requestSubmit();
    }
  }

  // Condition #3: Save query if the users focuses out of the search bar
  focusOut() {
    let save = document.getElementById('save-input');
    save.value = true;
    this.element.requestSubmit();
  }

  // focusIn() {
  //   // let input = document.getElementById('query');
  //   let save = document.getElementById('save-input');
  //   // input.value = '';
  //   save.value = false;
  //   this.element.requestSubmit();
  // }
}
