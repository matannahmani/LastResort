var barrackExchange = {
  'wood': 20,
  'iron': 20,
  'water': 20,
  'gold': 20
}
var wheelExchange = {
  'wood': 20,
  'iron': 20,
  'water': 20,
  'gold': 20
}
var boatExchange = {
  'wood': 20,
  'iron': 20,
  'water': 20,
  'gold': 20
}
var wallExchange = {
  'wood': 20,
  'iron': 20,
  'water': 20,
  'gold': 20
}



const buyStructure = () => {
  const buyButtons = document.querySelectorAll('.structure-buy-btn');
  buyButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const structureType = button.dataset.structure;


    });
  });
};
