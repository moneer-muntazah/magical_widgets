import 'package:flutter/material.dart';
import 'package:magical_widgets/magical_widgets.dart';

void main() {
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
        //         SimpleStep(text: 'text', status: SimpleStepStatus.present)
        //       ],
        //     ),
        //   ),
        // ),
        body: Center(
          child: SimpleStepper(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            doneColor: Colors.blue,
            activeColor: Colors.black,
            staleColor: Colors.grey,
            canceledColor: Colors.red,
            // steps: <SimpleStep>[
            //   SimpleStep(label: 'one', status: SimpleStepStatus.done),
            //   SimpleStep(label: 'two', status: SimpleStepStatus.active),
            //   SimpleStep(label: 'three', status: SimpleStepStatus.stale),
            //   SimpleStep(label: 'four', status: SimpleStepStatus.stale),
            // ],
            // steps: <SimpleStep>[
            //   SimpleStep(label: 'one', status: SimpleStepStatus.done),
            //   SimpleStep(label: 'two', status: SimpleStepStatus.done),
            //   SimpleStep(label: 'three', status: SimpleStepStatus.done),
            //   SimpleStep(label: 'four', status: SimpleStepStatus.canceled),
            // ],
            steps: <SimpleStep>[
              SimpleStep(label: 'one', status: SimpleStepStatus.done),
              SimpleStep(label: 'two', status: SimpleStepStatus.active),
              SimpleStep(label: 'three', status: SimpleStepStatus.stale),
              SimpleStep(label: 'four', status: SimpleStepStatus.stale),
            ],
          ),
        ),
      ),
    );
  }
}
