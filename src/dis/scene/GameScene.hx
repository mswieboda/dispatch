package dis.scene;

import dis.game.HeadsUpDisplay;
import dis.game.Player;

import hxt.input.Input;
import hxt.scene.Stage;
import hxt.scene.Scene;

import h2d.Graphics;
import h2d.Object;
import h2d.Text;
import hxd.res.DefaultFont;

class GameScene extends Scene {
  public static inline var TR_SPEED = 1;

  var player : Player;
  var hud : HeadsUpDisplay;
  var trOverlay : Object;
  var trText : Text;
  var isTrDone = false;

  public function new(stage : Stage, text : String) {
    super(stage);

    trOverlay = new Object();

    s2d.add(trOverlay, 1);

    var bg = new h2d.Graphics(s2d);

    //specify a color we want to draw with
    bg.beginFill(0x000000);
    bg.drawRect(0, 0, stage.s2d.width, stage.s2d.height);
    bg.endFill();

    trOverlay.addChild(bg);

    // NOTE: DefaultFont is 12, so keep factor of 12 for best results
    var trFont = DefaultFont.get().clone();
    trFont.resizeTo(24);

    var trText = new Text(trFont, s2d);
    trText.text = text;
    trText.x = (s2d.width - trText.textWidth) * 0.5;
    trText.y = s2d.height * 0.333 - trText.textHeight * 0.5;

    trOverlay.addChild(trText);

    player = new Player(s2d);
    hud = new HeadsUpDisplay(player, s2d);
  }

  public override function update(dt: Float) {
    if (!isTrDone) {
      if (isTr()) {
        trUpdate(dt);
      } else {
        isTrDone = true;
        trDone(dt);
      }
    } else {
      player.update(dt);
      hud.update(dt);
    }

    if (Input.menu.isPressed("exit")) {
      stage.changeScene(new MenuScene(stage));
    }
  }

  function isTr() : Bool {
    return trOverlay.alpha > 0;
  }

  function trUpdate(dt: Float) {
    trOverlay.alpha -= TR_SPEED * dt;
  }

  // NOTE: to be overridden by child scene
  function trDone(dt : Float) {}
}
