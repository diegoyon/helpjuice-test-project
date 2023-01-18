import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search-bar"
export default class extends Controller {
  // submits form every 100ms after typing
  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 100);
  }
}
