import 'package:flutter_cubing_timer/cubing/cubing_manager.dart';

final _cubingManager = CubingManager();


CubingManager getCB () {
  return _cubingManager;
}

String toNormalTime(double time){
  var hours = time ~/ 3600;
  time = ((time-hours*3600)*1000).roundToDouble()/1000;
  var minutes = time ~/ 60;
  var seconds = ((time-minutes*60)*1000).roundToDouble()/1000;
  if (hours != 0) return "$hours:$minutes:$seconds";
  if (minutes != 0) return "$minutes:$seconds";
  return "$seconds";
}