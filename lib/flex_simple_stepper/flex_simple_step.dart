import 'package:flutter/material.dart';
import 'flex_simple_stepper.dart';

enum FlexSimpleStepStatus { done, active, stale, canceled }

class FlexSimpleStep extends StatelessWidget {
  const FlexSimpleStep({required this.label, required this.status});

  final String label;
  final FlexSimpleStepStatus status;

  Icon _pickIcon() {
    switch (status) {
      case FlexSimpleStepStatus.done:
        return Icon(Icons.done);
      default:
        return Icon(Icons.cancel_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(FlexSimpleStepper.of(context)?.staleColor);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.pink,
          ),
          child: _pickIcon(),
        ),
        Text(label)
      ],
    );
  }
}
