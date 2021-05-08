import 'package:flutter/material.dart';
import 'package:flutter_cubing_timer/widgets/select_event_card.dart';

class TimerBottomSheet extends StatelessWidget {

  final List<EventCard> children;
  TimerBottomSheet({this.children});

  @override
  Widget build(BuildContext context) { //TODO изменить детей так чтобы можно было передавать не только одну строчку
    return Container(
        alignment: Alignment.center,
        height: 400,
        color: Colors.grey[300],
        child: Column(
          children: [
            Text("Select event", style: TextStyle(fontSize: 20)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: children
            )
          ],
        ));
  }

}