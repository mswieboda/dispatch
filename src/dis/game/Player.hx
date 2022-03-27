package dis.game;

import hxt.input.Input;
import hxt.obj2d.Obj;

import h2d.Bitmap;
import h2d.Object;
import h2d.Tile;

class Player extends Obj {
  public static inline var SPEED = 100;

  public function new(?parent : Object) {
    var sprite = new Bitmap(Tile.fromColor(0xcc0000, Grid.SIZE, Grid.SIZE));
    super(sprite, Grid.COLLIDER_SIZE, null, parent);
  }

  public function updateWithColliders(dt : Float, colliders : Array<Obj>) {
    updateMovement(dt, colliders);
  }

  function updateMovement(dt : Float, colliders : Array<Obj>) {
    var dx = 0;
    var dx_actual = 0.0;
    var dy = 0;
    var dy_actual = 0.0;

    if(Input.game.isDown("moveLeft")) {
      dx = -1;
    } else if(Input.game.isDown("moveRight")) {
      dx = 1;
    }

    if(Input.game.isDown("moveForward")) {
      dy = -1;
    } else if(Input.game.isDown("moveBackward")) {
      dy = 1;
    }

    if(dx != 0 || dy != 0) {
      var adjusted_dx = dx / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
      var adjusted_dy = dy / Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));

      dx_actual = dt * adjusted_dx * SPEED;
      dy_actual = dt * adjusted_dy * SPEED;

      x += dx_actual;
      y += dy_actual;

      for (collider in colliders) {
        if (collider.collided(this)) {
          x -= dx_actual;
          y -= dy_actual;

          break;
        }
      }
    }
  }
}
