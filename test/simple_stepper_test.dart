import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magical_widgets/simple_stepper.dart';

const doneColor = Colors.blue;
const activeColor = Colors.black;
const staleColor = Colors.grey;
const canceledColor = Colors.red;
const skipColor = Colors.purpleAccent;

const stepOneLabel = 'stepOneLabel';
const stepTwoLabel = 'stepTwoLabel';
const stepThreeLabel = 'stepThreeLabel';
const stepFourLabel = 'stepFourLabel';
const stepFiveLabel = 'stepFiveLabel';

extension SimpleStepperTester on WidgetTester {
  SimpleStepState simpleStepState(String label) {
    final parentData = renderObject(find.byWidgetPredicate(
            (widget) => widget is SimpleStepNode && widget.label == label))
        .parentData as SimpleStepperParentData;
    return parentData.state!;
  }
// SimpleStepNode simpleStepNode(String label) => widget(find.byWidgetPredicate(
//     (widget) => widget is SimpleStepNode && widget.label == label));
}

MaterialApp createApp({
  required TextDirection textDirection,
  required List<SimpleStep> steps,
}) =>
    MaterialApp(
      home: Scaffold(
        body: Directionality(
          textDirection: textDirection,
          child: SimpleStepper(
            doneColor: doneColor,
            activeColor: activeColor,
            staleColor: staleColor,
            canceledColor: canceledColor,
            skipColor: skipColor,
            steps: steps,
          ),
        ),
      ),
    );

void main() {
  testWidgets('test', (tester) async {
    final app = createApp(
      textDirection: TextDirection.ltr,
      steps: <SimpleStep>[
        SimpleStep(label: stepOneLabel, state: SimpleStepState.done),
        SimpleStep(label: stepTwoLabel, state: SimpleStepState.active),
        SimpleStep(label: stepThreeLabel, state: SimpleStepState.stale),
      ],
    );
    await tester.pumpWidget(app);
    final stepper = find.byType(SimpleStepper);
    expect(stepper, findsOneWidget);
    final stepOneFinder = find.text(stepOneLabel);
    expect(stepOneFinder, findsOneWidget);
    expect(tester.simpleStepState(stepOneLabel), SimpleStepState.done);

    expect(find.text(stepTwoLabel), findsOneWidget);
    expect(find.text(stepThreeLabel), findsOneWidget);
  });
}
