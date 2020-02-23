mapboxgl.accessToken = 'pk.eyJ1IjoibWF0YW5tYXRhbjk5OW5ldyIsImEiOiJjazYwcmptN3AwYWI5M2ZueHZkeWQ3OWx4In0.S0yh9SSTrRgBNldx_5ztGw';
import mapboxgl from 'mapbox-gl';

const map = new mapboxgl.Map({
  style: 'mapbox://styles/matanmatan999new/ck6c251js4mwd1imo5g3w2j2q',
  center: [-74.0066, 40.7135],
  zoom: 14,
  maxZoom: 15,
  minZoom: 13,
  pitch: 60,
  bearing: -17.6,
  container: 'map',
  antialias: true
});

const loadMap = () => {
  map.on('load', function() {
  let layers = map.getStyle().layers;

  let labelLayerId;
  for (let i = 0; i < layers.length; i++) {
  if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
  labelLayerId = layers[i].id;
  break;
  }
  }

  map.addLayer(
  {
    'id': '3d-buildings',
    'source': 'composite',
    'source-layer': 'building',
    'filter': ['==', 'extrude', 'true'],
    'type': 'fill-extrusion',
    'minzoom': 15,
    'paint': {
    'fill-extrusion-color': '#aaa',

  // use an 'interpolate' expression to add a smooth transition effect to the
  // buildings as the user zooms in
    'fill-extrusion-height': [
    'interpolate',
    ['linear'],
    ['zoom'],
    15,
    0,
    15.05,
    ['get', 'height']
    ],
    'fill-extrusion-base': [
    'interpolate',
    ['linear'],
    ['zoom'],
    15,
    0,
    15.05,
    ['get', 'min_height']
    ],
    'fill-extrusion-opacity': 0.4
    }
  },
  );
})
}
// The 'building' layer in the mapbox-streets vector source contains building-height
// data from OpenStreetMap.
// map.on('load', function() {
// // Insert the layer beneath any symbol layer.
// let layers = map.getStyle().layers;

// let labelLayerId;
// for (let i = 0; i < layers.length; i++) {
// if (layers[i].type === 'symbol' && layers[i].layout['text-field']) {
// labelLayerId = layers[i].id;
// break;
// }
// }

// map.addLayer(
// {
//   'id': '3d-buildings',
//   'source': 'composite',
//   'source-layer': 'building',
//   'filter': ['==', 'extrude', 'true'],
//   'type': 'fill-extrusion',
//   'minzoom': 15,
//   'paint': {
//   'fill-extrusion-color': '#aaa',

// // use an 'interpolate' expression to add a smooth transition effect to the
// // buildings as the user zooms in
//   'fill-extrusion-height': [
//   'interpolate',
//   ['linear'],
//   ['zoom'],
//   15,
//   0,
//   15.05,
//   ['get', 'height']
//   ],
//   'fill-extrusion-base': [
//   'interpolate',
//   ['linear'],
//   ['zoom'],
//   15,
//   0,
//   15.05,
//   ['get', 'min_height']
//   ],
//   'fill-extrusion-opacity': 0.4
//   }
// },
// );
// });

export {loadMap}
