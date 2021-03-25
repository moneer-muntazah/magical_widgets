/// Credit: https://stackoverflow.com/questions/61863958/how-can-i-paint-a-widget-on-a-canvas-in-flutter
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SimpleStepper extends MultiChildRenderObjectWidget {
  SimpleStepper({Key? key, this.activeColor, required List<Widget> steps})
      : super(key: key, children: steps);

  final Color? activeColor;

  @override
  _RenderSimpleStepper createRenderObject(BuildContext context) =>
      _RenderSimpleStepper(
          activeColor: activeColor ?? Theme.of(context).primaryColor);
}

class SimpleStep extends ContainerBoxParentData<RenderBox> {}

class _RenderSimpleStepper extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, SimpleStep> {
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
  void setupParentData(RenderObject child) {}

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredSize = Size(constraints.maxWidth, 50.0);
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
      final center =
          Offset((point1.dx + point2.dx) / 2, (point1.dy + point2.dy) / 2);
      context.paintChild(firstChild!, center);
    }

    context.canvas.restore();
  }
}
