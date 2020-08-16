package lunasurveyor;

enum abstract SCustomEvents(String) from String to String {
 public var SETUP_DEBUG = "setupDebug";
 public var SELECT_EVENT = "selectEvent";
}
