/// Credit: https://stackoverflow.com/questions/61863958/how-can-i-paint-a-widget-on-a-canvas-in-flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'simple_step.dart';

export 'simple_step.dart';

class SimpleStepper extends MultiChildRenderObjectWidget {
  SimpleStepper({Key? key, this.activeColor, required List<SimpleStep> steps})
      : super(key: key, children: steps);

  final Color? activeColor;

  @override
  _RenderSimpleStepper createRenderObject(BuildContext context) =>
      _RenderSimpleStepper(
          activeColor: activeColor ?? Theme
              .of(context)
              .primaryColor);

  @override
  void updateRenderObject(BuildContext context,
      _RenderSimpleStepper renderObject) =>
      renderObject..activeColor = activeColor!;
}

class _SimpleStepperParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderSimpleStepper extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _SimpleStepperParentData> {
  _RenderSimpleStepper({required Color activeColor})
      : _activeColor = activeColor;

  Color get activeColor => _activeColor;
  Color _activeColor;

  set activeColor(Color value) {
    if (_activeColor == value) return;
    _activeColor = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _SimpleStepperParentData) {
      child.parentData = _SimpleStepperParentData();
    }
  }

  @override
  void performLayout() {
    print(constraints);
    if (childCount > 0) {
      firstChild!.layout(
          constraints.copyWith(maxHeight: constraints.maxHeight / 10), parentUsesSize: true);
    }
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredSize = Size(
        constraints.maxWidth, constraints.maxHeight / 10);
    return constraints.constrain(desiredSize);
  }



  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);

    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = 5;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width, size.height / 2);
    context.canvas.drawLine(point1, point2, activePaint);

    if (childCount > 0) {
      // print(firstChild!.size);
      final childCenter =
      Offset(firstChild!.size.width / 2, firstChild!.size.height / 2);
      final parentCenter =
      Offset((point1.dx + point2.dx) / 2, (point1.dy + point2.dy) / 2);
      context.paintChild(
        firstChild!,
        Offset(
            parentCenter.dx - childCenter.dx, parentCenter.dy - childCenter.dy),
      );
    }

    context.canvas.restore();
  }
}
