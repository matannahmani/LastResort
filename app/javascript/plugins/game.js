const config = {
  type: Phaser.WEBGL,
  width: 375,
  height: 812,
  parent  : 'phaser-app',
  scene: {
    preload: preload,
    create: create,
    update: update,

  }
}
function preload() {
      this.load.image('tiles', '../../16x16s.png');
      // this.load.image('tiles2', '../mt2.png');
      this.load.tilemapTiledJSON('tilemap', '../../16x16s.json');
      var url = 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexpinchplugin.min.js';
      // scene.load.scenePlugin('rexuiplugin', 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexuiplugin.min.js', 'rexUI', 'rexUI');
      this.load.plugin('rexpinchplugin', url, true);
      this.load.scenePlugin('rexuiplugin', 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexuiplugin.min.js', 'rexUI', 'rexUI');
      this.load.image('btn', '../../basepop.png');
    }

function create() {
      // Creating layers calling screen adjusment


      // resizeApp();
      buildings_type = buildingList();

      this.add.image(0, 0, 'map').setOrigin(0);

      const map = this.make.tilemap({ key: 'tilemap' });

      const tiles = map.addTilesetImage('16x16s', 'tiles');

      const layer1 = map.createStaticLayer(0, tiles);

      layer2 = map.createStaticLayer(1, tiles);

      layer3 = map.createDynamicLayer(2, tiles);

      // Loading base , setting camera , setting up drag screen
      isplacing = [false]
      loadBase();
      const checkuser = checkUser();
      placeables = checkuser; // [true/false,name,amountLeft]
      buttons = this.rexUI.add.buttons({
          anchor: {
              left: 'left+10',
              centerY: 'bottom-20'
          },

          orientation: 'x',
          buttons: [
            createButton(this, 'Barracks'),
            createButton(this, 'Wall'),
            createButton(this, 'Boat'),
            createButton(this, 'Weel')
          ],

      })
      buttons.hideButton()
      buttons.layout();
      buttons.scrollFactorX = 0;
      buttons.scrollFactorY = 0;
      buttons
          .on('button.click', function (button, index, pointer, event) {
            placeables.forEach((item) =>{
              if (item[1] === button.text && item[2] !== 0){
                isplacing = [true,item[1],item[2]];
                item[2] -= 1;
              }
            });
          });
      // }
      buttons.forEachButtton((x,index) => {buttons.hideButton(index)});
      var cam = this.cameras.main;
      cam.centerToSize();
      cam.setBounds(0, 0, layer1.width, layer1.height);

      var dragScale = this.plugins.get('rexpinchplugin').add(this); // SETTING UP DRAG SCREEN
      dragScale
          .on('drag1', function (dragScale) {
            // debugger
              var drag1Vector = dragScale.drag1Vector;
              cam.scrollX -= drag1Vector.x / cam.zoom;
              cam.scrollY -= drag1Vector.y / cam.zoom;
          })
          .on('pinch', function (dragScale) {
              var scaleFactor = dragScale.scaleFactor;
              // if (cam.zoom < 2){
              cam.zoom *= scaleFactor;
            // }
          }, this);
}

var createButton = function (scene, text) {
    return scene.rexUI.add.label({
        width: 60,
        height: 40,
        background: scene.rexUI.add.roundRectangle(0, 0, 0, 0, 20, 0x7b5e57),
        text: scene.add.text(0, 0, text, {
            fontSize: 18
        }),
        space: {
            left: 10,
            right: 10,
        }
    });
}

function update() {
  buttons.forEachButtton((x,index) => {buttons.hideButton(index)});
  placeables.forEach((item,index) => {
    if (item[1] === 'Barracks' && item[2] > 0) buttons.showButton(0);
    if (item[1] === 'Wall' && item[2] > 0) buttons.showButton(1);
    if (item[1] === 'Boat' && item[2] > 0) buttons.showButton(2);
    if (item[1] === 'Weel' && item[2] > 0) buttons.showButton(3);
    buttons.layout();
  });
  // TO DO - add checking if its a wall if so display diffrent
  if (isplacing[0] === true && isplacing[2] > 0){
    const worldPoint = this.input.activePointer.positionToCamera(this.cameras.main); // click cords.
    // Draw tiles (only within the groundLayer)
    if (this.input.manager.activePointer.isDown) { // check if screen is clicked
      tilePoint = layer3.worldToTileXY(worldPoint.x,worldPoint.y); // get tile grid x + y

      // for (let i =0;i< )
      if (layer2.hasTileAtWorldXY(worldPoint.x, worldPoint.y) === false && layer3.hasTileAtWorldXY(worldPoint.x, worldPoint.y) === false) // check if has tile placed
      {
      // debugger
      layer3.putTilesAt(buildings_type[isplacing[1]],tilePoint.x - 2,tilePoint.y - 3);
      let draw = `layer3.putTilesAt(buildings_type['${isplacing[1]}'],${tilePoint.x - 2},${tilePoint.y - 3});`
      isplacing[0] = false;
      isplacing[2] -= 1;
      updateBase({base: draw,name: isplacing[1]}); // send the dra+w command to the server
      }
    }
  }
}

function resizeApp ()
{
  // Width-height-ratio of game resolution
    // Replace 360 with your game width, and replace 640 with your game height
  let game_ratio    = 375 / 812;

  // Make div full height of browser and keep the ratio of game resolution
  let div     = document.getElementById('phaser-app');
  div.style.width   = (window.innerHeight * game_ratio) + 'px';
  div.style.height  = window.innerHeight + 'px';

  // Check if device DPI messes up the width-height-ratio
  let canvas      = document.getElementsByTagName('canvas')[0];

  let dpi_w = parseInt(div.style.width) / canvas.width;
  let dpi_h = parseInt(div.style.height) / canvas.height;

  let height  = window.innerHeight * (dpi_w / dpi_h);
  let width = height * game_ratio;

  // Scale canvas
  canvas.style.width  = width + 'px';
  canvas.style.height = height + 'px';
}

// function ifhasTile(type){
//   switch (type) {
//     case 'Barracks':

//       break;
//     default:
//       // statements_def
//       break;
//   }
// }

//   function ifhasTilehelp(height,width){
//     let bool = false;
//     for(let i=0, i < height, i++ ){
//       for(let j=0, j < width, j++ ){
//         bool = layer3.hastile
//         }
//       }
//     }

 // Fetching user buildings commands, then drawing

function loadBase() {
  fetch('../base')
    .then((response) => {
      return response.json();
    })
    .then((commands) => {
      commands.msg.forEach((command) =>{
        eval(command);
      })
    });
}

// Fetching if user bought new structure, then enable drawing

function checkUser() {
  const isplacing = [];
  fetch('../base/checkupdate')
    .then((response) => {
      return response.json();
    })
    .then((buildings) => {
      if (buildings.result === true)
        buildings.msg.forEach((build) =>{
          isplacing.push([false,Object.keys(build)[0],Object.values(build)[0]]);
        });
    });
    return isplacing;
}

// Sending new draw command to the server to be saved for next load.
function updateBase(data) {
    // Default options are marked with *
    fetch('../base', {
      method: 'PATCH', // *GET, POST, PUT, DELETE, etc.
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

    return response.json(); // parses JSON response into native JavaScript objects
  });
}

function buildingList() {
  const buildings_type = {} // 0 = barracks , 1 = wall , 2 = boat , 3 = weel
  buildings_type['Barracks'] = [[18509,18510,18511,18512,0],[18649,18650,18651,18652,0],[18789,18790,18791,18792,0],[18929,18930,18931,18932,0],[19069,19070,19071,19072,0],[19209,19210,19211,19212,0]];
  buildings_type['Wall'] = [8474]; // wall
  buildings_type['Boat'] = [[0,0,0,8655,8656,8657,0,0],[8792,8793,8794,8795,8796,8797,8798,8799],[0,8933,8934,8935,8936,8937,8938,8939],[0,0,9074,9075,9076,9077,9078,9079]]
  buildings_type['Weel'] = [[17389,17390,17391,17392],[17529,17530,17531,17532],[17669,17670,17671,17672],[17809,17810,17811,17812],[17949,17950,17951,17952]]
  return buildings_type;
}

window.game = new Phaser.Game(config);
