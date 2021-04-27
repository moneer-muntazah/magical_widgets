import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magical_widgets/simple_stepper.dart';

const doneColor = Colors.blue;
const activeColor = Colors.black;
const staleColor = Colors.grey;
const canceledColor = Colors.red;
const skipColor = Colors.purpleAccent;

/// Unique step labels. [SimpleStepperTester] assumes that no two steps in any
/// test should share the same label.
const stepOneLabel = 'stepOneLabel';
const stepTwoLabel = 'stepTwoLabel';
const stepThreeLabel = 'stepThreeLabel';
const stepFourLabel = 'stepFourLabel';
const stepFiveLabel = 'stepFiveLabel';

extension SimpleStepperTester on WidgetTester {
  RenderFlex stepper() =>
      renderObject(find.byType(SimpleStepper)) as RenderFlex;

  RenderObject step(String label) => renderObject(find.byWidgetPredicate(
      (widget) => widget is SimpleStepNode && widget.label == label));

  SimpleStepState? stepState(RenderObject step) {
    final parentData = step.parentData;
    assert(parentData is SimpleStepperParentData);
    return (step.parentData as SimpleStepperParentData).state;
  }
}

MaterialApp createApp({
  required List<SimpleStep> steps,
}) =>
    MaterialApp(
      home: Scaffold(
        body: SimpleStepper(
          doneColor: doneColor,
          activeColor: activeColor,
          staleColor: staleColor,
          canceledColor: canceledColor,
          skipColor: skipColor,
          steps: steps,
        ),
      ),
    );

void main() {
  testWidgets('Sample: done, active, and stale', (tester) async {
    final app = createApp(
      steps: <SimpleStep>[
        SimpleStep(label: stepOneLabel, state: SimpleStepState.done),
        SimpleStep(label: stepTwoLabel, state: SimpleStepState.active),
        SimpleStep(label: stepThreeLabel, state: SimpleStepState.stale),
      ],
    );
    await tester.pumpWidget(app);
    expect(find.byType(SimpleStepper), findsOneWidget);
    expect(find.text(stepOneLabel), findsOneWidget);
    final stepper = tester.stepper();
    final stepOne = tester.step(stepOneLabel);
    expect(tester.stepState(stepOne), SimpleStepState.done);
    expect(stepper.firstChild, stepOne);

    expect(find.text(stepTwoLabel), findsOneWidget);
    final stepTwo = tester.step(stepTwoLabel);
    expect(tester.stepState(stepTwo), SimpleStepState.active);
    expect(stepper.childAfter(stepOne as RenderBox), stepTwo);

    expect(find.text(stepThreeLabel), findsOneWidget);
    final stepThree = tester.step(stepThreeLabel);
    expect(tester.stepState(stepThree), SimpleStepState.stale);
    expect(stepper.childAfter(stepTwo as RenderBox), stepThree);
  });

  testWidgets('Sample: done, done, and done', (tester) async {
    final app = createApp(
      steps: <SimpleStep>[
        SimpleStep(label: stepOneLabel, state: SimpleStepState.done),
        SimpleStep(label: stepTwoLabel, state: SimpleStepState.done),
        SimpleStep(label: stepThreeLabel, state: SimpleStepState.done),
      ],
    );
    await tester.pumpWidget(app);
    expect(find.byType(SimpleStepper), findsOneWidget);
    expect(find.text(stepOneLabel), findsOneWidget);
    final stepper = tester.stepper();
    final stepOne = tester.step(stepOneLabel);
    expect(tester.stepState(stepOne), SimpleStepState.done);
    expect(stepper.firstChild, stepOne);

    expect(find.text(stepTwoLabel), findsOneWidget);
    final stepTwo = tester.step(stepTwoLabel);
    expect(tester.stepState(stepTwo), SimpleStepState.done);
    expect(stepper.childAfter(stepOne as RenderBox), stepTwo);

    expect(find.text(stepThreeLabel), findsOneWidget);
    final stepThree = tester.step(stepThreeLabel);
    expect(tester.stepState(stepThree), SimpleStepState.done);
    expect(stepper.childAfter(stepTwo as RenderBox), stepThree);
  });

  testWidgets('Sample: done, skip, and canceled', (tester) async {
    final app = createApp(
      steps: <SimpleStep>[
        SimpleStep(label: stepOneLabel, state: SimpleStepState.done),
        SimpleStep(label: stepTwoLabel, state: SimpleStepState.skip),
        SimpleStep(label: stepThreeLabel, state: SimpleStepState.canceled),
      ],
    );
    await tester.pumpWidget(app);
    expect(find.byType(SimpleStepper), findsOneWidget);
    expect(find.text(stepOneLabel), findsOneWidget);
    final stepper = tester.stepper();
    final stepOne = tester.step(stepOneLabel);
    expect(tester.stepState(stepOne), SimpleStepState.done);
    expect(stepper.firstChild, stepOne);

    expect(find.text(stepTwoLabel), findsOneWidget);
    final stepTwo = tester.step(stepTwoLabel);
    expect(tester.stepState(stepTwo), SimpleStepState.skip);
    expect(stepper.childAfter(stepOne as RenderBox), stepTwo);

    expect(find.text(stepThreeLabel), findsOneWidget);
    final stepThree = tester.step(stepThreeLabel);
    expect(tester.stepState(stepThree), SimpleStepState.canceled);
    expect(stepper.childAfter(stepTwo as RenderBox), stepThree);
  });
}
