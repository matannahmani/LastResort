const config = {
  type: Phaser.AUTO,
  width: 375,
  height: 812,
  scene: {
    preload: preload,
    create: create,
    update: update
  }
}
function preload() {
      this.load.image('tiles', '../fortuna-tiles.png');
      this.load.tilemapTiledJSON('tilemap', '../test.json');
      var url = 'https://raw.githubusercontent.com/rexrainbow/phaser3-rex-notes/master/dist/rexpinchplugin.min.js';
      this.load.plugin('rexpinchplugin', url, true);
    }

function create() {
      this.add.image(0, 0, 'map').setOrigin(0);

      var map = this.make.tilemap({ key: 'tilemap' });

      var tiles = map.addTilesetImage('fortuna-tiles', 'tiles');

      const layer = map.createStaticLayer(0, tiles);
      const layer1 = map.createStaticLayer(1, tiles);

      var cam = this.cameras.main;
      cam.setBounds(0, 0, map.displayWidth, map.displayHeight);

      this.input.on('pointermove', function (p) {
        if (!p.isDown) return;
        cam.scrollX -= (p.position.x - p.prevPosition.x) / 4;
        cam.scrollY -= (p.position.y - p.prevPosition.y) / 4;
      });
}

function update() {
  // updatecamera();
}

function updatecamera(cam, dragScale) {
  // if (this.game.input.activePointer.isDown) {
  //   if (this.game.origDragPoint) {
  //   // move the camera by the amount the mouse has moved since last update
  //   cam.main.scrollX +=
  //     this.game.origDragPoint.x - this.game.input.activePointer.position.x;
  //   this.cameras.main.scrollY +=
  //     this.game.origDragPoint.y - this.game.input.activePointer.position.y;
  //   } // set new drag origin to current position
  //   this.game.origDragPoint = this.game.input.activePointer.position.clone();
  // } else {
  //   this.game.origDragPoint = null;
  // }

         // var camera = this.cameras.main;
         dragScale
             .on('drag1', function (dragScale) {
                 var drag1Vector = dragScale.drag1Vector;
                 cam.scrollX -= drag1Vector.x / cam.zoom;
                 cam.scrollY -= drag1Vector.y / cam.zoom;
             })
             .on('pinch', function (dragScale) {
                 var scaleFactor = dragScale.scaleFactor;
                 cam.zoom *= scaleFactor;
             }, this)
}
window.game = new Phaser.Game(config);
