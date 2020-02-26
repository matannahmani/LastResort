import mapboxgl from 'mapbox-gl';
let allmarkers = []
let map;
let newMarker;
    function cleaner(markers) {
    if (markers.length > 0 ) {
      markers.forEach(marker => {
        if (marker["_update"]!==null) {
          marker.remove();
        }
      })
      // for (var i = markers.length - 1; i >= 0; i--) {
      //   markers[i].remove();
      // }
    }
  }
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => {
    bounds.extend([ marker.longitude, marker.latitude ])
    allmarkers.push(marker);
    // console.log(markers);
  });
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey
    map = new mapboxgl.Map({
      style: 'mapbox://styles/matanmatan999new/ck6c251js4mwd1imo5g3w2j2q',
      center: [-74.0066, 40.7135],
      zoom: 14,
      maxZoom: 20,
      minZoom: 13,
      pitch: 60,
      bearing: -17.6,
      container: 'map',
      antialias: true
    });

    // The 'building' layer in the mapbox-streets vector source contains building-height
    // data from OpenStreetMap.
    map.on('load', function() {
    // Insert the layer beneath any symbol layer.
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
    });
    map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true
      })
    );

    // const markerCreator = () => {
    // }
      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
      newMarker = new mapboxgl.Marker()
        .setLngLat([ marker.longitude, marker.latitude ])
        .addTo(map);
        if (marker)
      allmarkers.push(newMarker)
      });


      fitMapToMarkers(map, markers);


    const extractHTML = "<a href=''>Extract</a>"

    class MyCustomControl {
      onAdd(map){
        this.map = map;
        this.container = document.createElement('div');
        this.container.className = 'my-custom-control mapboxgl-ctrl';
        this.container.innerHTML = extractHTML;
        return this.container;
      }
      onRemove(){
        this.container.parentNode.removeChild(this.container);
        this.map = undefined;
      }
    }

    const myCustomControl = new MyCustomControl();

    map.addControl(myCustomControl, 'bottom-left');




    const buttonDiv = document.querySelector('.my-custom-control')
    buttonDiv.addEventListener('click', (event) => {
      event.preventDefault()
      navigator.geolocation.getCurrentPosition(function(position) {
        let lat = position.coords.latitude;
        let lng = position.coords.longitude;


      postData('extract', {latitude: lat, longitude: lng});
      // get
      fetch('extract')
        .then((response) => {
          return response.json();
        })
        .then((markers) => {
          console.log(markers);
          console.log(allmarkers);
          cleaner(allmarkers);
          console.log(allmarkers);
          markers.forEach((marker) => {
          console.log(marker)
          newMarker = new mapboxgl.Marker()
            .setLngLat([ marker.longitude, marker.latitude ])
            .addTo(map);
          });

          fitMapToMarkers(map, markers);
        });


      });
      async function postData(url , data ) {
        // Default options are marked with *
        const response = await fetch(url, {
          method: 'POST', // *GET, POST, PUT, DELETE, etc.
          mode: 'cors', // no-cors, *cors, same-origin
          cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
          credentials: 'same-origin', // include, *same-origin, omit
          headers: {
            'Content-Type': 'application/json'
            // 'Content-Type': 'application/x-www-form-urlencoded',
          },
          redirect: 'follow', // manual, *follow, error
          referrerPolicy: 'no-referrer', // no-referrer, *client
          body: JSON.stringify(data) // body data type must match "Content-Type" header
        });
        // return await response.json(); // parses JSON response into native JavaScript objects
      }

    });

  }
};

export {initMapbox}
