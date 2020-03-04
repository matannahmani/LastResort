const getCurrentMaterialElement = () => {
  const element = document.querySelector('.resource-chooser.selected')
  return element
}

const getMaxForCurrentResource = () => {
  const currentMaterialElement = getCurrentMaterialElement()
  const elementAmount = currentMaterialElement.dataset.amount
  return elementAmount
}

const setResourceAmount = (amount) => {
  const $exchangeAmount = document.getElementById('amount')
  $exchangeAmount.value = amount

  document.querySelector('.spinner-view').innerText = amount

  let gemValue = document.getElementById('gem-value');
  if(gemValue) {
    gemValue.innerText = (amount / 20);
  }
}

const filterAmount = () => {
  const elementAmount = getMaxForCurrentResource()
  const $exchangeAmount = document.getElementById('amount')
  let exchangeAmount = $exchangeAmount.value
  exchangeAmount = Math.min(exchangeAmount, elementAmount)
  setResourceAmount(exchangeAmount)
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

const tryAmountSpin = (amount) => {
  // If no resource selected, don't go further
  if (!getCurrentMaterialElement()) {
    return
  }

  let spinAmount = parseInt(amount)
  const $exchangeAmount = document.getElementById('amount')
  let oldAmount = parseInt($exchangeAmount.value)

  const maxForCurrentResource = getMaxForCurrentResource()
  let newAmount = oldAmount + spinAmount
  // testing
  if (newAmount > maxForCurrentResource) {
    return
  }
  if (newAmount < 0) {
    return
  }
  setResourceAmount(oldAmount + spinAmount)
}

const setupNumberSpinner = () => {
  const upArrow = document.querySelector(
    '.material-amount-spinner .spinner-arrow-up')
  const downArrow = document.querySelector(
    '.material-amount-spinner .spinner-arrow-down')

  upArrow.addEventListener('click', () => {
    tryAmountSpin(20)
  })

  downArrow.addEventListener('click', () => {
    tryAmountSpin(-20)
  })
}

const setupExchangeForm = () => {
  document.addEventListener('DOMContentLoaded', () => {
    setupResourceSelectorButtons()
    setupNumberSpinner()
    setupAmountInput()
    setResourceAmount(0)
  })
}

export { setupExchangeForm }
