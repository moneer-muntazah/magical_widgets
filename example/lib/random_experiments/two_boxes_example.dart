import 'package:flutter/material.dart';
import 'package:magical_widgets/magical_widgets.dart' show TwoBoxes;

class TwoBoxesExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 250.0, maxWidth: 300, minHeight: 250.0, maxHeight: 300.0),
        child: ColoredBox(
          color: Colors.blue,
          child: TwoBoxes(
            color: Colors.deepOrange,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints.tightFor(width: 100.0, height: 100.0),
              child: ColoredBox(
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
