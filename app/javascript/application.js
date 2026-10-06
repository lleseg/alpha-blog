// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import * as bootstrap from 'bootstrap';

const showToasts = () => {
  const toastElementList = document.querySelectorAll('.toast:not(.show)');

  [...toastElementList].map((toastElement) => {
    const toast = new bootstrap.Toast(toastElement);

    toast.show();
  });
};

document.addEventListener('DOMContentLoaded', showToasts);

document.addEventListener('turbo:load', showToasts);
