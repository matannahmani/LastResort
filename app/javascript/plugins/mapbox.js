import mapboxgl from 'mapbox-gl';
import { initSweetalert } from '../plugins/init_sweetalert';

let allmarkers = []
let map;
let newMarker;
let markersToShow;
    function cleaner(markers) {
    if (markers.length > 0 ) {
      markers.forEach(marker => {
          marker.remove();
      })
    }
  }
const fitMapToMarkers = (map, markers) => {
  if (typeof markers !== 'undefined') {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => {
    bounds.extend([ marker.longitude, marker.latitude ])
  });
  map.fitBounds(bounds, { padding: 80, maxZoom: 15, duration: 0});
  }
};

const createCustomMarkers = (element, marker) => {
  element.className = 'marker';
  element.style.backgroundImage = `url('${marker.image_url}')`;
  element.style.backgroundSize = 'contain';
  element.style.width = '10px';
  element.style.height = '10px';
}

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey
    map = new mapboxgl.Map({
      style: 'mapbox://styles/matanmatan999new/ck6c251js4mwd1imo5g3w2j2q',
      center: [-74.0066, 40.7135],
      zoom: 14,
      maxZoom: 16,
      minZoom: 13,
      pitch: 60,
      bearing: -17.6,
      container: 'map',
      antialias: false
    });

    // The 'building' layer in the mapbox-streets vector source contains building-height
    // data from OpenStreetMap.
    map.on('load', function() {
    // Insert the layer beneath any symbol layer.
    document.querySelector('.mapboxgl-ctrl-icon').addEventListener('click', (click) =>{
      navigator.geolocation.getCurrentPosition(function(position) {
        let lat = position.coords.latitude;
        let lng = position.coords.longitude;
        fetch('./mylocation', {
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
          body: JSON.stringify({latitude: lat,longitude: lng }) // body data type must match "Content-Type" header
        }).then((response) => {
          response.json().then((data) => {
            if (data.response === 200){
              console.log(allmarkers)
              cleaner(allmarkers);
              allmarkers = [];
              console.log(data.markers)
              data.markers.forEach((resource) => {
                const element = document.createElement('div');
                createCustomMarkers(element, resource)
                newMarker = new mapboxgl.Marker(element)
                  .setLngLat([ resource.longitude, resource.latitude ])
                  .addTo(map);
                allmarkers.push(newMarker);
                });
              fitMapToMarkers(map, data.markers);
              }
            });
          });
      });
    });
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
      const element = document.createElement('div');
      createCustomMarkers(element, marker)
      newMarker = new mapboxgl.Marker(element)
        .setLngLat([ marker.longitude, marker.latitude ])
        .addTo(map);
        if (marker)
      allmarkers.push(newMarker)
    });

    fitMapToMarkers(map, markers);


    const extractHTML = "<button id='btn-extract-resource' class=''>Extract</button>"

    // check if find my location is clicked

    class MyCustomControl {
      onAdd(map){
        this.map = map;
        this.container = document.createElement('div');
        this.container.className = 'extract-button mapboxgl-ctrl';
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




    const buttonDiv = document.querySelector('.extract-button')
    buttonDiv.addEventListener('click', (event) => {
      event.preventDefault()
      navigator.geolocation.getCurrentPosition(function(position) {
        let lat = position.coords.latitude;
        let lng = position.coords.longitude;

        postData('extract', {latitude: lat, longitude: lng });


      });
     const postData = async (url , data,getloc = false ) => {
        // Default options are marked with *
        let answer = null;

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
        }).then((response) => {
             response.json().then((data) => {
              console.log(data.allResources)
              console.log(data.pickedResources)
              cleaner(allmarkers);
              data.allResources.forEach((resource) => {
                const element = document.createElement('div');
                createCustomMarkers(element, resource)
                newMarker = new mapboxgl.Marker(element)
                  .setLngLat([ resource.longitude, resource.latitude ])
                  .addTo(map);
              });
              fitMapToMarkers(map, data.allResources);
              if (getloc === false) // checks if its fetch (true means its being called from get location)
              {
                if (data.pickedResources.length === 0) {
                  initSweetalert('#map', 'btn-extract-resource', {
                            title: "Get closer!",
                              text: `You're not close enough to any resource.`,
                              icon: "error"
                            }, (value) => {
                              console.log(data)
                            });

                } else {
                  initSweetalert('#map', 'btn-extract-resource', {
                            title: "Extracted!",
                              text: `${data.pickedResources[0].resource.amount} ${data.pickedResources[0].resource_name} units have been added to your inventory.`,
                              icon: "success"
                            }, (value) => {
                              console.log(data)
                            });
                }
              }
            }).catch((err) => {
                console.log(err);
            })
        });
      }

    });

  }
};



export {initMapbox}
