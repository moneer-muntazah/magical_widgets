import 'package:flutter/material.dart';
import 'simple_stepper_example.dart';

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
        body: SimpleStepperExample(),
      ),
    );
  }
}
