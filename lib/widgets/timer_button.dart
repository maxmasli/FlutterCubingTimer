import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget{
  var child;
  Function function;
  TimerButton({this.child, this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 1))),
        child: RawMaterialButton(

            child: child,
            onPressed: function
        ),
      ),
    );
  }
}