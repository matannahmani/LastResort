
document.addEventListener('DOMContentLoaded', () => {
  let switchBTN = document.querySelector('#switch');
  // let shopBTN = document.querySelector('#shop')
  let mapbox = document.querySelector('.mapboxgl-map');
  let gamemap = document.querySelectorAll('canvas');
  let gamemap1 = document.querySelectorAll('.mapboxgl-canvas');
  let geomap = document.querySelector('.con');
  let base = document.querySelector('#phaser-app');
  let ismap = true;
  setTimeout(function(){
      gamemap = document.querySelectorAll('canvas');
      gamemap[1].style.position = 'absolute';
      gamemap[1].style.top = 0;
      gamemap[1].style.right = 0;
      checkmap();
    });

  switchBTN.addEventListener('click', click => {
    checkmap();
    });


  function checkmap() {
    if (ismap === false){
      base.style.zIndex = 1;
      mapbox.style.zIndex = 2;
      ismap = true;
    }
    else{
      mapbox.style.zIndex = 1;
      base.style.zIndex = 2;
      ismap = false;
    }
  }
});
