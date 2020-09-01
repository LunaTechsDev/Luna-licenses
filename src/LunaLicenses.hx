import rm.abstracts.windows.WindowScrollText;
import rm.windows.Window_ScrollText;
import rm.scenes.Scene_Base;
import rm.scenes.Scene_MenuBase;
import rm.core.Rectangle;
import core.Amaryllis;
import rm.Globals;
import rm.windows.Window_TitleCommand;
import rm.managers.AudioManager;
import rm.scenes.Scene_Map;
import rm.managers.SceneManager;
import core.Types.JsFn;
import rm.scenes.Scene_Title;
import utils.Fn;

class LunaLicenses {
 public static var commandName: String = "";
 public static var licenseText: String = "";

 public static function main() {
  var params = Globals.Plugins.filter((plugin) -> {
   return ~/<LunaLicenses>/ig.match(plugin.description);
  })[0].parameters;
  commandName = params["CommandName"];
  var textInformation = "";
  Amaryllis.loadText("/licenses.txt").then((result) -> {
   trace(result);
   textInformation = result;
   licenseText = result;
  });
  final textContent = "";
  var winTitleCommand = Fn.renameClass(Window_TitleCommand,
   LTWindowTitleCommand);
 }
}

@:keep
class LTWindowTitleCommand extends Window_TitleCommand {
 #if compileMV
 public function new(x: Int, y: Int) {
  super(x, y);
 }
 #else
 public function new(rect: Rectangle) {
  super(rect);
 }
 #end

 public override function makeCommandList() {
  super.makeCommandList();
  this.addCommand(LunaLicenses.commandName, "license", true);
  this.setHandler("license", handleLicenseCommand);
 }

 public function handleLicenseCommand() {
  trace("Handle License Command");
  SceneManager.push(LTSceneLicenses);
 }
}

@:keep
class LTSceneLicenses extends Scene_Base {
 private var _licenseWindow: Window_ScrollText;

 public override function create() {
  super.create();
  this.createLicenseWindow();
 }

 public override function start() {
  super.start();
  this.startText(LunaLicenses.licenseText);
 }

 public function createLicenseWindow() {
  this._licenseWindow = new WindowScrollText(0, 0, 300, 400);
  this.addWindow(this._licenseWindow);
 }

 public function startText(text: String) {
  Globals.GameMessage.add(text);
  Globals.GameMessage.setScroll(3, true);
  this._licenseWindow.startMessage();
 }
}
