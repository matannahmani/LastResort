const config = {
  type: Phaser.AUTO,
  width: 375,
  height: 812,
  scene: {
    preload() {
      this.load.image('tiles', 'fortuna-tiles.png');
      this.load.tilemapTiledJSON('tilemap', 'mymap.json');
    },

    create() {
      var map = this.make.tilemap({ key: 'tilemap' });

      var tiles = map.addTilesetImage('fortuna-tiles', 'tiles');

      const layer = map.createStaticLayer(0, tiles);
    },
  }
};

window.game = new Phaser.Game(config);
