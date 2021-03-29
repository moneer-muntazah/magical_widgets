//import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

enum SimpleStepStatus { past, present, future }

class SimpleStep extends StatelessWidget {
  const SimpleStep({Key? key, required this.text, required this.status})
      : super(key: key);

  final String text;
  final SimpleStepStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
      ),
      constraints: BoxConstraints.expand(),
      child: Icon(Icons.done),
    );
    // imposes unconstrained height
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: <Widget>[
    //     Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: Colors.pink,
    //       ),
    //       constraints: BoxConstraints.expand(),
    //       child: Icon(Icons.done),
    //     ),
    //   ],
    // );
  }
}
