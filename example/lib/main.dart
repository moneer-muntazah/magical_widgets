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
        //       child: Container(width: 100, height: 100, color: Colors.black),
        //     ),
        //   ),
        // ),
        body: const Center(
          child: Text('coming soon...'),
        ),
      ),
    );
  }
}
