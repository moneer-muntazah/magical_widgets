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
        body: Center(
          child: ColoredBox(
            color: Colors.orange.shade100,
            child: ProgressBar(
                barColor: Colors.red,
                thumbColor: Colors.blueGrey,
                thumbSize: 25),
          ),
        ),
      ),
    );
  }
}
