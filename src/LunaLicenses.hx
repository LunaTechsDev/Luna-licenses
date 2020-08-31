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

 public static function main() {
  var params = Globals.Plugins.filter((plugin) -> {
   return ~/<LunaLicenses>/ig.match(plugin.description);
  })[0].parameters;
  var commandName: String = params["CommandName"];
  var winTitleCommand = Fn.renameClass(Window_TitleCommand,
   LTWindowTitleCommand);
 }
}

@:keep
class LTWindowTitleCommand extends Window_TitleCommand {
 public override function makeCommandList() {
  super.makeCommandList();
  this.addCommand(LunaLicenses.commandName, "license", true);
  this.setHandler("license", handleLicenseCommand);
 }

 public function handleLicenseCommand() {
  trace("Handle License Command");
 }
}
