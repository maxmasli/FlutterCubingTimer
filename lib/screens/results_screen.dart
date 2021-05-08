import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubing_timer/utils.dart';
import 'package:flutter_cubing_timer/widgets/result_list_tile.dart';

class ResultsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResultsScreen();

}

class _ResultsScreen extends State {

  var _value = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("sadadas"),//TODO доделать авг лучшее худшее
                  Text("sadadas"),
                  Text("sadadas"),
                  Text("sadadas"),
                ],
              ),
              DropdownButton( // TODO доделать эту хрень чтобы норм было
                value: 1,
                items: [
                  DropdownMenuItem(child: Text("2x2x2"), value: 0),
                  DropdownMenuItem(child: Text("3x3x3"), value: 1),
                  DropdownMenuItem(child: Text("pyraminx"), value: 2),
                ],
                onChanged: (int value) {
                  setState(() {
                    _value = value;
                  });
                },
              )
            ],
          ),
        ),
        Divider(thickness: 2, color: Colors.black),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: ListView.builder(
              itemCount: getCB().getCount(),
              itemBuilder: (BuildContext context, int index) {
                return ResultListTile(
                  result: getCB().getResults()[getCB().getCount()-1-index],
                );
              },

            )
          )
        )
      ],
    );
  }
}