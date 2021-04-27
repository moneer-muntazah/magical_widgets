import 'package:flutter/material.dart';
import 'package:magical_widgets/magical_widgets.dart'
    show SimpleStepper, SimpleStep, SimpleStepState;

class SimpleStepperExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SimpleStepper(
          doneColor: Colors.blue,
          activeColor: Colors.black,
          staleColor: Colors.grey,
          canceledColor: Colors.red,
          // steps: <SimpleStep>[
          //   SimpleStep(label: 'one', state: SimpleStepState.done),
          //   SimpleStep(label: 'two', state: SimpleStepState.active),
          //   SimpleStep(label: 'three', state: SimpleStepState.stale),
          //   SimpleStep(label: 'four', state: SimpleStepState.stale),
          // ],
          // steps: <SimpleStep>[
          //   SimpleStep(label: 'one', state: SimpleStepState.done),
          //   SimpleStep(label: 'two', state: SimpleStepState.done),
          //   SimpleStep(label: 'three', state: SimpleStepState.done),
          //   SimpleStep(label: 'four', state: SimpleStepState.canceled),
          // ],
          // steps: <SimpleStep>[
          //   SimpleStep(label: 'one', state: SimpleStepState.done),
          //   SimpleStep(label: 'two', state: SimpleStepState.active),
          //   SimpleStep(label: 'three', state: SimpleStepState.stale),
          //   SimpleStep(label: 'four', state: SimpleStepState.stale),
          // ],
          // steps: <SimpleStep>[
          //   SimpleStep(label: 'first step', state: SimpleStepState.done),
          //   SimpleStep(label: 'second step', state: SimpleStepState.done),
          //   SimpleStep(label: 'third step', state: SimpleStepState.active),
          //   SimpleStep(
          //       label: 'fourth step and my favorite',
          //       state: SimpleStepState.stale),
          // ],
          // steps: <SimpleStep>[
          //   SimpleStep(label: 'first step', state: SimpleStepState.done),
          //   SimpleStep(label: 'second step', state: SimpleStepState.done),
          //   SimpleStep(label: 'third step', state: SimpleStepState.done),
          //   SimpleStep(
          //       label: 'fourth step and my favorite',
          //       state: SimpleStepState.stale),
          // ],
          steps: <SimpleStep>[
            SimpleStep(label: 'first step', state: SimpleStepState.done),
            SimpleStep(label: 'second step', state: SimpleStepState.skip),
            SimpleStep(label: 'third step', state: SimpleStepState.skip),
            SimpleStep(
                label: 'fourth step and my favorite',
                state: SimpleStepState.canceled),
          ],
        ),
      ),
    );
  }
}
