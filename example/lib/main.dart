import 'package:flutter/material.dart';

//import 'package:flutter/rendering.dart';
import 'package:magical_widgets/magical_widgets.dart';

void main() {
  // debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Magical Widgets'),
        ),
        // body: Center(
        //   child: ColoredBox(
        //     color: Colors.orange.shade100,
        //     child: ProgressBarLeaf(
        //         barColor: Colors.red,
        //         thumbColor: Colors.blueGrey,
        //         thumbSize: 25),
        //   ),
        // ),
        // body: Center(
        //   child: ColoredBox(
        //     color: Colors.orange.shade100,
        //     child: ProgressBarSingleChild(
        //       barColor: Colors.red,
        //       child: Container(width: 20, height: 20, color: Colors.black),
        //     ),
        //   ),
        // ),
        // body: const Center(
        //   child: Text('coming soon...'),
        // ),
        // body: Center(
        //   child: Tint(
        //     color: Color.fromARGB(40, 255, 0, 0),
        //     child: Text(
        //       'Hello World!',
        //       textDirection: TextDirection.ltr,
        //     ),
        //   ),
        // ),
        // body: Center(
        //   child: ColoredBox(
        //     color: Colors.brown.shade100,
        //     child: SimpleStepper(
        //       activeColor: Colors.orange.shade700,
        //       steps: <SimpleStep>[
        //         SimpleStep(text: 'text', state: SimpleStepState.present)
        //       ],
        //     ),
        //   ),
        // ),
        body: Center(
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
        ),
      ),
    );
  }
}
