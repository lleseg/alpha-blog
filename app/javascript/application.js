// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import 'bootstrap';

const showToasts = () => {
  document.querySelectorAll('.toast:not(.show)').forEach((toastElement) => {
    window.bootstrap.Toast.getOrCreateInstance(toastElement).show();
  });
};

document.addEventListener('DOMContentLoaded', showToasts);
document.addEventListener('turbo:load', showToasts);
document.addEventListener('turbo:render', showToasts);
