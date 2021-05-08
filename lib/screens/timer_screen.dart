import 'package:flutter/material.dart';
import 'package:flutter_cubing_timer/assets/strings.dart';
import 'package:flutter_cubing_timer/assets/styles.dart';
import 'package:flutter_cubing_timer/cubing/avg.dart';
import 'package:flutter_cubing_timer/cubing/event.dart';
import 'package:flutter_cubing_timer/utils.dart';
import 'package:flutter_cubing_timer/cubing/result.dart';
import 'package:flutter_cubing_timer/widgets/select_event_card.dart';
import 'package:flutter_cubing_timer/widgets/timer_bottom_sheet.dart';
import 'package:flutter_cubing_timer/widgets/timer_button.dart';

class TimerScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TimerScreen(getCB());

}

class _TimerScreen extends State {
  _TimerScreen(_cubingManager) {
    this._cubingManager = _cubingManager;
  }

  var _isStarted = false;
  var _currentTimerValue = standartResultText;
  var _colorTextTimer = Colors.black;
  var _cubingManager;
  var _currentScramble;
  var _currentCount;
  var _avg5Value;
  var _avg12Value;
  var _avg50Value;
  var _avg100Value;
  var _isDNFButtonEnabled;
  var _isPlus2ButtonEnabled;

  var _startedTime = 0;

  @override
  void initState() {
    super.initState();
    updateScramble();
    update();
  }

  void updateScramble() {
    _currentScramble = _cubingManager.getRandomScramble();
  }

  void update() {
    _currentCount = _cubingManager.getCount();
    if (_currentCount == 0) {
      _isDNFButtonEnabled = false;
      _isPlus2ButtonEnabled = false;
    } else {
      _isDNFButtonEnabled = true;
      _isPlus2ButtonEnabled = true;
    }
    var time = _cubingManager.getLast();
    if (time == null) {
      _currentTimerValue = standartResultText;
    } else if (time.isDNF()) {
      _currentTimerValue = DNFText;
    } else {
      _currentTimerValue = toNormalTime(time.getTime());
    }
    _avg5Value = _cubingManager.getAvg(Avg.avg5);
    if (_avg5Value == null) _avg5Value = notCountText;
    else if (_avg5Value == -1) _avg5Value = DNFText;
    else _avg5Value = toNormalTime(_avg5Value);

    _avg12Value = _cubingManager.getAvg(Avg.avg12);
    if (_avg12Value == null) _avg12Value = notCountText;
    else if (_avg12Value == -1) _avg12Value = DNFText;
    else _avg12Value = toNormalTime(_avg12Value);

    _avg50Value = _cubingManager.getAvg(Avg.avg50);
    if (_avg50Value == null) _avg50Value = notCountText;
    else if (_avg50Value == -1) _avg50Value = DNFText;
    else _avg50Value = toNormalTime(_avg50Value);

    _avg100Value = _cubingManager.getAvg(Avg.avg100);
    if (_avg100Value == null) _avg100Value = notCountText;
    else if (_avg100Value == -1) _avg100Value = DNFText;
    else _avg100Value = toNormalTime(_avg100Value);
  }

  void onTapDown(details) {
    var result;
    setState(() {
      _colorTextTimer = Colors.green;
      if (_isStarted) {
        result = DateTime.now().millisecondsSinceEpoch - _startedTime;
        _cubingManager.addResult(Result((result / 1000), _currentScramble));
        updateScramble();
        update();
      }
    });
  }

  void onTapUp(details) {
    setState(() {
      _colorTextTimer = Colors.black;
      if (!_isStarted) {
        _startedTime = DateTime.now().millisecondsSinceEpoch;
        _isStarted = true;
        _currentTimerValue = startedTimerText;
      } else {
        _isStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              _currentScramble,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              //onTapDown: (details) => onTapDown(details),
              onTapUp: (details) => onTapUp(details),
              onPanEnd: (details) => onTapUp(details),
              //onPanStart: (details) => onTapDown(details),
              onPanDown: (details) => onTapDown(details),
              child: Container(
                  color: Color(0x00FAFAFA),
                  alignment: Alignment.center,
                  child: Text(
                    _currentTimerValue,
                    style: TextStyle(fontSize: 100, color: _colorTextTimer),
                  )),
            ),
          ),
          Container(
            height: 35,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                TimerButton(
                  child: Icon(Icons.update),
                  function: () {
                    if (_isDNFButtonEnabled) {
                      setState(() {
                        _cubingManager
                            .getLast()
                            .setDNF(!(_cubingManager.getLast().isDNF()));
                      });
                    }
                    update();
                  },
                ),
                Container(width: 1, color: Colors.black),
                TimerButton(
                  child: Icon(Icons.add),
                  function: () {
                    if (_isPlus2ButtonEnabled) {
                      setState(() {
                        _cubingManager
                            .getLast()
                            .setPlus2(!(_cubingManager.getLast().isPlus2()));
                        update();
                      });
                    }
                  },
                ),
                Container(width: 1, color: Colors.black),
                TimerButton(
                  child: Icon(Icons.clear),
                  function: () {
                    setState(() {
                      _cubingManager.removeResult(_cubingManager.getLast());
                      update();
                    });
                  },
                ),
                Container(width: 1, color: Colors.black),
                TimerButton(
                  child: Icon(Icons.add_to_photos_rounded),
                  function: () {
                    Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
                      return TimerBottomSheet(
                        children: [
                          EventCard(
                            icon: Icons.accessibility_outlined,
                            text: "2x2x2",
                            onTap: () {
                              setState(() {
                                _cubingManager.changeEventTo(Event.EVENT_222);
                                update();
                                updateScramble();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          EventCard(
                            icon: Icons.add_to_photos,
                            text: "3x3x3",
                            onTap: () {
                              setState(() {
                                _cubingManager.changeEventTo(Event.EVENT_333);
                                update();
                                updateScramble();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          EventCard(
                            icon: Icons.accessible,
                            text: "Pyraminx",
                            onTap: () {
                              print("pyraminx");
                            },
                          ),
                        ],
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //выводятся результаты среднего времени
                        Row(
                          children: [
                            Text(
                              avg5Text,
                              style: avgsTextStyle,
                            ),
                            Text(
                              _avg5Value != null
                                  ? _avg5Value
                                  : notCountText,
                              style: avgsTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              avg12Text,
                              style: avgsTextStyle,
                            ),
                            Text(
                              _avg12Value != null
                                  ? _avg12Value
                                  : notCountText,
                              style: avgsTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              avg50Text,
                              style: avgsTextStyle,
                            ),
                            Text(
                              _avg50Value != null
                                  ? _avg50Value
                                  : notCountText,
                              style: avgsTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              avg100Text,
                              style: avgsTextStyle,
                            ),
                            Text(
                              _avg100Value != null
                                  ? _avg100Value
                                  : notCountText,
                              style: avgsTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Count: ", style: avgsTextStyle),
                        Text(
                            _currentCount != null
                                ? _currentCount.toString()
                                : zeroText,
                            style: avgsTextStyle)
                      ],
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
