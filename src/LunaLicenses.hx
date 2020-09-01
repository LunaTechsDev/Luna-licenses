import rm.windows.Window_Help;
import rm.abstracts.windows.WindowHelp;
import rm.core.Graphics;
import rm.abstracts.windows.WindowScrollText;
import rm.windows.Window_ScrollText;
import rm.scenes.Scene_Base;
import rm.core.Rectangle;
import core.Amaryllis;
import rm.Globals;
import rm.windows.Window_TitleCommand;
import rm.managers.SceneManager;
import utils.Fn;

class LunaLicenses {
 public static var commandName: String = "";
 public static var scrollSpeed: Int = 0;
 public static var licenseText: String = "";

 public static function main() {
  var params = Globals.Plugins.filter((plugin) -> {
   return ~/<LunaLicenses>/ig.match(plugin.description);
  })[0].parameters;
  commandName = params["CommandName"];
  scrollSpeed = Fn.parseIntJs(params["ScrollSpeed"], 10);

  Amaryllis.loadText("/licenses.txt").then((result) -> {
   trace(result);
   licenseText = result;
  });

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
 private var _helpWindow: Window_Help;
 private var _licenseWindow: Window_ScrollText;

 public override function create() {
  super.create();
  this.createWindowLayer();
  this.createLicenseHelpWindow();
  this.createLicenseWindow();
 }

 public override function start() {
  super.start();
  this.startText(LunaLicenses.licenseText);
 }

 public function createLicenseHelpWindow() {
  this._helpWindow = new WindowHelp(1, 0, 0, Graphics.boxWidth, 75);
  this._helpWindow.setText(LunaLicenses.commandName);
  this.addWindow(this._helpWindow);
 }

 public function createLicenseWindow() {
  var yOffset = cast this._helpWindow.height;
  this._licenseWindow = new WindowScrollText(0, yOffset, Graphics.boxWidth,
   Graphics.boxHeight - yOffset);
  this.addWindow(this._licenseWindow);
 }

 public function startText(text: String) {
  Globals.GameMessage.add(text);
  Globals.GameMessage.setScroll(3, true);
  this._licenseWindow.setBackgroundType(0);
  this._licenseWindow.startMessage();
 }
}
