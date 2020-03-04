window.onload = function() {
let switchBTN = document.querySelector('#switch');
// let shopBTH = document.querySelector('#shop')
let mapbox = document.querySelector('.mapboxgl-map');
let gamemap = document.querySelectorAll('canvas');
let gamemap1 = document.querySelectorAll('.mapboxgl-canvas');
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

shopBTN.addEventListener('click', click => {
  shop();
  });

function shop () {
  //redirect to a user-units page
}


function checkmap() {
  if (ismap === false){
    gamemap[1].style.display = 'none';
    mapbox.style.display = 'block';
    ismap = true;
  }
  else{
    mapbox.style.display = 'none';
    gamemap[1].style.display = 'block';
    ismap = false;
  }
}
};
