import swal from 'sweetalert';

const initSweetalert = (parentSelector, elementId, options = {}, callback = () => {}) => {
  swal(options)
};

export { initSweetalert };
