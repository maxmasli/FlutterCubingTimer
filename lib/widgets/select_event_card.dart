import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {

  IconData icon;
  Function onTap;
  String text;

  EventCard({this.icon, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 60,),
                Text(text)
              ],
            ),
          ),
        ),
      ),
    );

  }

}