import "bootstrap";
import { setupExchangeForm } from '../plugins/exchange'
import { buyStructure } from './newStructure'
import { buySoldier } from './newSoldier'

buySoldier()
buyStructure()

setupExchangeForm()

// import checkmap from "./dom"
// import config from "./game"
// import loadMap from "./mapbox";



// window.addEventListener('onload' , () => {
//   loadMap()
//   checkmap()
// })
