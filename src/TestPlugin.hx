import mz.windows.Window_Message;
import mz.managers.PluginManager;
import utils.Fn;
import utils.Comment;
import mz.windows.Window_Message;
import mz.sprites.Sprite_Base;

using core.StringExtensions;
using Std;

class TestPlugin {
	public static var textSpeed:Int = 2;

	public static function main() {
		trace(Sprite_Base);
		Comment.pluginParams("
   @author Kino
   @plugindesc An extension to the core Message Window functionality
   to support Visual Novels <KITA_MessageExt>.

   @param Text Speed 
   @desc The speed at which characters will be rendered
   @default 2
   
   @help
   Version: 1.00
   Version Log:
   Now you can change the text speed at will using escape characters
   inside the window.
   Example: \\TS[30] updates the text speed to super slow 30.
   Note: The [30] will appear in the editor, but not in game.

   Instructions:
   You set your text speed in the plugin menu.
   This is the speed that the characters will be drawn at.

   Contact me via forums; username: Kino.
   Hope this plugin helps and enjoy!
   ");

		var parameters:Any = PluginManager.parameters("KITA_MessageExt");
		textSpeed = Fn.getByArrSyntax(parameters, "Text Speed");
		trace(textSpeed);

		var newWinMsg = Fn.renameClass(Window_Message, MessageWinNew);
	}
}

class MessageWinNew extends Window_Message {
	public var activeTextSpeed:Int;
	public var originalTextSpeed:Int;

	public function new(x, y, width, height) {
		super(x, y, width, height);
		this.originalTextSpeed = TestPlugin.textSpeed;
		this.activeTextSpeed = TestPlugin.textSpeed;
	}

	public function updateTextSpeed(value) {
		this.activeTextSpeed = value;
	}

	public override function processEscapeCharacter(code:String, textState:String) {
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

	public override function processNormalCharacter(textState:String) {
		super.processNormalCharacter(textState);
		this.startWait(this.activeTextSpeed);
	}

	public override function terminateMessage() {
		this.activeTextSpeed = this.originalTextSpeed;
		super.terminateMessage();
	}
}
