const config = {
  type: Phaser.WEBGL,
  width: 375,
  height: 812,
  parent  : 'phaser-app',
  scene: {
    preload: preload,
    create: create,
    update: update
  }
}
function preload() {
      this.load.image('tiles', '../../16x16s.png');
      // this.load.image('tiles2', '../mt2.png');
      this.load.tilemapTiledJSON('tilemap', '../../16x16s.json');
      var url = 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexpinchplugin.min.js';
      // url2 = 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexvirtualjoystickplugin.min.js';
      // this.load.plugin('rexvirtualjoystickplugin', url2, true);
      this.load.plugin('rexpinchplugin', url, true);

      // game.input.touch.preventDefault = false;
    }

function create() {
      // window.addEventListener('resize', resize);
      // resizeApp();
      this.add.image(0, 0, 'map').setOrigin(0);

      var map = this.make.tilemap({ key: 'tilemap' });

      var tiles = map.addTilesetImage('16x16s', 'tiles');
      // var tiles2 = map.addTilesetImage('mt2', 'tiles2');

      const layer1 = map.createStaticLayer(0, tiles);
      const layer2 = map.createStaticLayer(1, tiles);
      const layer3 = map.createStaticLayer(2, tiles);
      // const layer1 = map.createStaticLayer(1, tiles2);

      var cam = this.cameras.main;
      cam.centerToSize();
      cam.setBounds(0, 0, layer1.width, layer1.height);
      // console.log(map);
      // this.input.on('pointermove', function (p) {
      //   debugger
      //   if (!p.isDown) return;
      //   cam.scrollX -= (p.position.x - p.prevPosition.x) / 4;
      //   cam.scrollY -= (p.position.y - p.prevPosition.y) / 4;
      // });
      var dragScale = this.plugins.get('rexpinchplugin').add(this);
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

function update() {
  // updatecamera();
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
window.game = new Phaser.Game(config);

