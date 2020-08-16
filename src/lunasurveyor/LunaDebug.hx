package lunasurveyor;

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
 }
}
