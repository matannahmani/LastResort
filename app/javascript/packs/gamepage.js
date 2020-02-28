import "../plugins/phaser.js";
import "../plugins/game.js";
import "../plugins/dom.js"
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/mapbox';

initMapbox();
