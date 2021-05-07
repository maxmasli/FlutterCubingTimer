import 'package:flutter/material.dart';
import 'package:flutter_cubing_timer/screens/results_screen.dart';
import 'package:flutter_cubing_timer/screens/settings_screen.dart';
import 'package:flutter_cubing_timer/screens/timer_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(CubingTimer());
}

class CubingTimer extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CubingTimer();
}

class _CubingTimer extends State{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  void _onItemTaped(index) {
    setState(() {
      _currentPage = index;
    });
  }

  var _currentPage = 1;
  var _pages = [
    SettingsScreen(),
    TimerScreen(),
    ResultsScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterCubingTimer",
      home: Scaffold(
        body: _pages.elementAt(_currentPage),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey[700],

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),
            BottomNavigationBarItem(icon: Icon(Icons.toc), label: "Results"),
          ],

          currentIndex: _currentPage,
          onTap: (inValue) => _onItemTaped(inValue),
        ),
      )
    );
  }
  
}


