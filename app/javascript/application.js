// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';

// code
let searchBar = document.getElementById('search-bar');
let searchButton = document.getElementById('search-button');
// console.log(searchBar);
searchBar.addEventListener('input', filterList);

function filterList() {
  const filter = searchBar.value.toLowerCase();
  const listItems = document.querySelectorAll('.article-item');

  listItems.forEach((item) => {
    let text = item.textContent;
    if (text.toLowerCase().includes(filter.toLowerCase())) {
      item.style.display = '';
    } else {
      item.style.display = 'none';
    }
  });
}
