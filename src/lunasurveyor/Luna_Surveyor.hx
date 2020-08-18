package lunasurveyor;

import mz.Globals;
import mz.scenes.Scene_Map;
import haxe.Timer;
import lunasurveyor.Events.SCustomEvents;
import core.Amaryllis;
import utils.Fn;
import mz.scenes.Scene_Base;
import utils.Comment;
import macros.MacroTools;

@:nullSafety(Strict)
class Luna_Surveyor {
 public static var surveyorEmitter = Amaryllis.createEventEmitter();

 public static function main() {
  Comment.pluginParams("
  @author Kino
  @plugindesc An extension to the MV/MZ core that allows you to modify the in game ui
  as a UI Kit <Luna_Surveyor>.");

  Comment.title("Setup Events");
  surveyorEmitter.on(SCustomEvents.SETUP_DEBUG, () -> {
   LunaDebug.initializeDebug();
  });

  surveyorEmitter.on(SCustomEvents.ON_MAP, () -> {
   LunaDebug.setMapInfo(Globals.GameMap);
  });

  Comment.title("Base Class Overrides");
  var SurveyorSceneBase = Fn.renameClass(Scene_Base, SurveyorSceneBaseExt);
  var SurveyorSceneMap = Fn.renameClass(Scene_Map, SurveyorSceneMapExt);
 }

 public static function setupDebugTool() {
  var Timer = Timer.delay(() -> {
   surveyorEmitter.emit(SCustomEvents.SETUP_DEBUG);
  }, 1500);
 }
}

@:keep
class SurveyorSceneBaseExt extends Scene_Base {
 public function new() {
  super();
 }

 override public function create() {
  super.create();
  Luna_Surveyor.setupDebugTool();
  // HeliosWinMgr.clearWindows();
  // Helios.setupHeliosWinManager();
  // Helios.addEditor();
 }
}

@:keep
class SurveyorSceneMapExt extends Scene_Map {
 public function new() {
  super();
 }

 override public function onMapLoaded() {
  super.onMapLoaded();
  Luna_Surveyor.surveyorEmitter.emit(SCustomEvents.ON_MAP);
 }
}
