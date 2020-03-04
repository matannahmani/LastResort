
const markSelected = (button) => {
  // 1. mark all buttons as not selected
  document.querySelectorAll('.soldier-selector').forEach((btn) => {
    btn.classList.remove('selected')
  })
  // 2. mark THIS button as selected
  button.classList.add('selected')
}

const buySoldier = () => {

  const buttons = document.querySelectorAll('.soldier-selector');
  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      markSelected(button);
      const soldierAmount = button.dataset.amount;
      // 3. find hidden form field for resource type
      const hiddenField = document.getElementById('unit_amount');
      // 4. set its value
      hiddenField.value = soldierAmount;
    });
  });
};



export {buySoldier}
