package lunasurveyor;

import mz.Globals;
import mz.abstracts.objects.GameMap;
import js.html.MouseEvent;
import lunasurveyor.Events.SCustomEvents;
import mz.abstracts.objects.GameEvent;
import js.Browser;
import haxe.ui.Toolkit;
import lunasurveyor.components.MainView;

class LunaDebug {
 public static var mainView = new MainView();

 public static function initializeDebug() {
  Toolkit.init({
   container: Browser.document.body,
  });
  var element = Browser.document.createElement("style");

  element.textContent = ".haxeui-component {z-Index:150}";
  Browser.document.head.appendChild(element);
  var gameCanvas = Browser.document.getElementById("ErrorPrinter");
  Browser.document.body.insertBefore(mainView.element, gameCanvas);
  trace("Added Debug to the current scene.");

  setupMouseEvents();
 }

 public static function setupMouseEvents() {
  Browser.document.addEventListener(SCustomEvents.MOUSE_DOWN,
   (event : MouseEvent) -> {
    var mapX = Globals.GameMap.canvasToMapX(event.clientX);
    var mapY = Globals.GameMap.canvasToMapY(event.clientY);
    var gameEvent = Globals.GameMap.eventsXy(mapX, mapY).shift();
    setEventInformation(gameEvent);
   }, {passive: false});
 }

 public static function setEventInformation(event: GameEvent) {
  mainView.setEventName(event.characterName());
  mainView.setEventXCoordinate(event.x);
  mainView.setEventYCoordinate(event.y);
 }
}
