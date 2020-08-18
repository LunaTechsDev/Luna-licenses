import macros.MacroTools;
import mz.windows.Window_Message;
import mz.managers.PluginManager;
import utils.Fn;
import utils.Comment;
import mz.windows.Window_Message;
import mz.sprites.Sprite_Base;

using core.StringExtensions;
using Std;

class TestPlugin {
 public static var textSpeed: Int = 2;

 public static function main() {
  trace(Sprite_Base);
  // Plugin parameters can be include here as an internal call.
  MacroTools.includeJsLib("./TestPluginParams.js");

  var parameters: Any = PluginManager.parameters("TestPlugin");
  textSpeed = Fn.getByArrSyntax(parameters, "Text Speed");
  trace(textSpeed);

  var newWinMsg = Fn.renameClass(Window_Message, MessageWinNew);
 }
}

class MessageWinNew extends Window_Message {
 public var activeTextSpeed: Int;
 public var originalTextSpeed: Int;

 public function new(x, y, width, height) {
  super(x, y, width, height);
  this.originalTextSpeed = TestPlugin.textSpeed;
  this.activeTextSpeed = TestPlugin.textSpeed;
 }

 public function updateTextSpeed(value) {
  this.activeTextSpeed = value;
 }

 public override function processEscapeCharacter(code: String,
   textState: String) {
  switch (code) {
   case '$':
    this._goldWindow.open();
   case '.':
    this.startWait(15);
   case '!':
    this.startPause();

   case '>':
    this._lineShowFast = true;

   case '<':
    this._lineShowFast = false;

   case '^':
    this._pauseSkip = true;

   case 'TS':
    this.updateTextSpeed(this.obtainEscapeParam(textState).int());
   case _:
    super.processEscapeCharacter(code, textState);
  }
 }

 public override function processNormalCharacter(textState: String) {
  super.processNormalCharacter(textState);
  this.startWait(this.activeTextSpeed);
 }

 public override function terminateMessage() {
  this.activeTextSpeed = this.originalTextSpeed;
  super.terminateMessage();
 }
}
