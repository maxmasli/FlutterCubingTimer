import 'package:flutter_cubing_timer/cubing/avg.dart';
import 'package:flutter_cubing_timer/cubing/event.dart';
import 'package:flutter_cubing_timer/cubing/result.dart';
import 'dart:math';

class CubingManager {
  final _rnd = Random();

  var _results333 = <Result>[];
  var _results222 = <Result>[];

  Event _currentEvent = Event.EVENT_333;

  void setDNF(Result result, bool isDNF){
    result.setDNF(isDNF);
  }

  void addResult(Result result) {
    switch (_currentEvent) {
      case Event.EVENT_222:
        _results222.add(result);
        break;
      case Event.EVENT_333:
        _results333.add(result);
        break;

    }
  }

  void removeResult(Result result) {
    switch (_currentEvent) {
      case Event.EVENT_222:
        _results222.remove(result);
        break;
      case Event.EVENT_333:
        _results333.remove(result);
        break;

    }
  }

  Result getLast() {
    switch(_currentEvent) {
      case Event.EVENT_222:
        if (_results222.length != 0){
          return _results222.last;
        }
        return null;
      case Event.EVENT_333:
        if (_results333.length != 0){
          return _results333.last;
        }
        return null;
      default: return null;
    }
  }

  void changeEventTo(Event event){
    _currentEvent = event;
  }

  List<Result> getResults() {
    switch (_currentEvent) {
      case Event.EVENT_222:
        return _results222;
      case Event.EVENT_333:
        return _results333;
      default:
        return null;
    }
  }

  String getRandomScramble() {
    switch (_currentEvent) {
      case Event.EVENT_222:
        return _get222RandomScramble();
      case Event.EVENT_333:
        return _get333RandomScramble();
      default:
        return null;
    }
  }

  int getCount() {
    switch (_currentEvent) {
      case Event.EVENT_222:
        return _results222.length;
      case Event.EVENT_333:
        return _results333.length;
      default:
        return null;
    }
  }

  double getAvg(countAvg) {
    var l;
    var count;
    List countL = [];
    switch (_currentEvent) {
      case Event.EVENT_222:
        l = _results222; break;
      case Event.EVENT_333:
        l = _results333; break;
    }
    switch(countAvg) {
      case Avg.avg5:
        count = 5; break;
      case Avg.avg12:
        count = 12; break;
      case Avg.avg50:
        count = 50; break;
      case Avg.avg100:
        count = 100; break;
    }
    if (l.length < count) return null;
    countL.addAll(l.reversed.take(count));
    countL.remove(_getMax(countL));
    countL.remove(_getMin(countL));
    double sum = 0;
    for (Result d in countL) {
      if (d.isDNF()) return -1;
      sum += d.getTime();
    }
    return (sum*1000/(count-2)).round() / 1000.0;
  }

  String _get333RandomScramble(){
    var lit = [["F", "F'", "F2"],
      ["B", "B'", "B2"],
      ["U", "U'", "U2"],
      ["D", "D'", "D2"],
      ["R", "R'", "R2"],
      ["L", "L'", "L2"]];

    var res = "";

    var scr = [];
    var banned = [];

    while (true) {
      var i = _rnd.nextInt(6);
      var j = _rnd.nextInt(3);

      if ((scr.length > 2 && scr.elementAt(scr.length-2) == lit[i][j]) || banned.contains(i)) {
        continue;
      }
      res += lit[i][j] + " ";
      scr.add(lit[i][j]);

      if ((i % 2 != 0 && banned.contains(i - 1)) || (i % 2 == 0 && banned.contains(i + 1))) {
        banned.add(i);
      } else {
        banned.clear();
        banned.add(i);
      }

      if (scr.length >= 20) {
        break;
      }
    }
    return res;
  }

  //TODO сделать этот прикол
  String _get222RandomScramble () {
    return null;
  }

}

Result _getMax(countL) {
  var max = countL[0];
  for (Result d in countL) {
    if (d.getTime() > max.getTime()) {
      max = d;
    }
    if (d.isDNF()) {
      return d;
    }
  }
  return max;
}

Result _getMin(countL) {
  var min = countL[0];
  for (Result d in countL) {
    if (d.getTime() < min.getTime()) {
      min = d;
    }
  }
  return min;
}