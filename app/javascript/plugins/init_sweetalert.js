import swal from 'sweetalert';

const initSweetalert = (parentSelector, elementId, options = {}, callback = () => {}) => {
  document.querySelector(parentSelector).addEventListener('click', (e) => {
    if (e.target && e.target.id == elementId) {
      swal(options).then(callback);

    }
  })
};

export { initSweetalert };
