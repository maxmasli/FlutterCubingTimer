import 'package:flutter/material.dart';
import 'package:flutter_cubing_timer/assets/strings.dart';

import '../utils.dart';

class ResultListTile extends StatelessWidget {
  final result;

  ResultListTile({this.result});

  String getTime(result) {
    if (result.isDNF()) return DNFText;
    return toNormalTime(result.getTime());
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     border: Border.all(
    //       width: 2,
    //       color: Colors.black,
    //     ),
    //     borderRadius: BorderRadius.circular(15.0)
    //   ),
    //   padding: EdgeInsets.all(10),
    //   margin: EdgeInsets.all(5),
    //   child: Row(
    //     children: [
    //       Text("${result.getTime()}"),
    //       SizedBox(width: 5),
    //       Text("${result.getScramble()}", textAlign: TextAlign.left,)
    //     ],
    //   )
    // );

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        leading: Text("${getTime(result)}", style: TextStyle(fontSize: 20)),
        title: Text("${result.getScramble()}"),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    //mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          children: [
                            Text("${result.getTime()} ", style: TextStyle(fontSize: 20)),
                            Text("${result.isDNF() == true ? DNFText : ""}",
                              style: TextStyle(color: Colors.red, fontSize: 20),)
                          ]
                      ),
                      Divider(color: Colors.grey[400]),
                      Text("${result.getScramble()}")
                    ],
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
