package dis.scene;

import hxt.input.Input;
import hxt.obj2d.Obj;
import hxt.scene.Stage;
import hxt.scene.Scene;

import h2d.Bitmap;
import h2d.Graphics;
import hxd.Res;
import h2d.Text;
import h2d.Tile;
import hxd.res.DefaultFont;

class MainScene extends GameScene {
  var glowObj : Obj;

  public function new(stage : Stage) {
    super(stage, "dispatch");

    // background trees
    var objTile = Tile.fromColor(0x00cc00, 16, 64);
    var objsData = [
      {x: 100, y: 200},
      {x: 500, y: 300},
      {x: 600, y: 600},
    ];

    for (objData in objsData) {
      var objSprite = new Bitmap(objTile, s2d);
      var obj = new Obj(objSprite, null, null, s2d);
      obj.x = objData.x;
      obj.y = objData.y;
    }

    var glowObjSprite = new Bitmap(objTile, s2d);
    glowObj = new Obj(glowObjSprite, null, null, s2d);
    glowObj.x = 500;
    glowObj.y = 300;
    glowObj.filter = new h2d.filter.Glow(0xff6600);

    player.x = 500;
    player.y = 500;
  }

  public override function update(dt: Float) {
    super.update(dt);

    if (!isTrDone) {
      return;
    }

    // TODO: do a custom sort using height, not just y
    s2d.ysort(0);
  }
}
