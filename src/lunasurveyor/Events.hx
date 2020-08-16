package lunasurveyor;

enum abstract SCustomEvents(String) from String to String {
 public var MOUSE_DOWN = "mousedown";
 public var SETUP_DEBUG = "setupDebug";
 public var SELECT_EVENT = "selectEvent";
 public var SHOW_DEBUG = "showDebug";
 public var HIDE_DEBUG = "hideDebug";
 public var ON_MAP = "onmap";
}
