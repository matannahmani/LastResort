import "bootstrap";
import { setupExchangeForm } from '../plugins/exchange'
import { buyStructure } from './newStructure'
import { unitsSweetalert } from '../plugins/units_sweetalert';
import { buySoldier } from './newSoldier'
import {$,jQuery} from 'jquery';
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

