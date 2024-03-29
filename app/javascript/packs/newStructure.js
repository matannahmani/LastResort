
const markSelected = (button) => {
  // 1. mark all buttons as not selected
  document.querySelectorAll('.structure-selector').forEach((btn) => {
    btn.classList.remove('selected')
  })
  // 2. mark THIS button as selected
  button.classList.add('selected')
}

const buyStructure = () => {

  const buttons = document.querySelectorAll('.structure-selector');
  buttons.forEach((button) => {

    button.addEventListener('click', () => {
      markSelected(button);
      const structureType = button.dataset.structure;
      // 3. find hidden form field for resource type
      const hiddenField = document.getElementById('structure');
      // 4. set its value
      hiddenField.value = structureType;

    });
  });
};



export {buyStructure}
