import rm.managers.AudioManager;
import rm.scenes.Scene_Map;
import rm.managers.SceneManager;
import core.Types.JsFn;
import rm.scenes.Scene_Title;
import utils.Fn;

class LunaSkipTitle {
 public static function main() {
  var oldsceneTitleStart: JsFn = Fn.getPrProp(Scene_Title, "start");
  Fn.setPrProp(Scene_Title, "start", () -> {
   oldsceneTitleStart.call(Fn.self);
   AudioManager.stopAll();
   SceneManager.goto(Scene_Map);
  });
 }
}
