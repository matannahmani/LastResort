const getCurrentMaterialElement = () => {
  const element = document.querySelector('.resource-chooser.selected')
  return element
}

const filterAmount = () => {
  const currentMaterialElement = getCurrentMaterialElement()
  const elementAmount = currentMaterialElement.dataset.amount

  const $exchangeAmount = document.getElementById('amount')
  let exchangeAmount = $exchangeAmount.value
  exchangeAmount = Math.min(exchangeAmount, elementAmount)
  $exchangeAmount.value = exchangeAmount
}

const markSelected = (button) => {
  // 1. mark all buttons as not selected
  document.querySelectorAll('.resource-chooser').forEach((btn) => {
    btn.classList.remove('selected')
  })
  // 2. mark THIS button as selected
  button.classList.add('selected')
}

const setupResourceSelectorButtons = () => {
  const buttons = document.querySelectorAll('.resource-chooser')
  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      markSelected(button)
      // 2. get its resource type
      const resourceType = button.dataset.resource
      // 3. find hidden form field for resource type
      const hiddenField = document.getElementById('material')
      // 4. set its value
      hiddenField.value = resourceType
      // 5. Filter amount
      filterAmount()
    })
  })
}

const setupAmountInput = () => {
  const $exchangeAmount = document.getElementById('amount')
  $exchangeAmount && $exchangeAmount.addEventListener('change', () => {
    filterAmount()
  })
}

const setupExchangeForm = () => {
  document.addEventListener('DOMContentLoaded', () => {
    setupResourceSelectorButtons()
    setupAmountInput()
  })
}

export { setupExchangeForm }
