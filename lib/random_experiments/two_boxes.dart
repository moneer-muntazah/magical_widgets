import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TwoBoxes extends SingleChildRenderObjectWidget {
  const TwoBoxes({Key? key, required this.color, required Widget child})
      : super(child: child);

  final Color color;

  @override
  _RenderTwoBoxes createRenderObject(BuildContext context) =>
      _RenderTwoBoxes(color);

  @override
  void updateRenderObject(
          BuildContext context, _RenderTwoBoxes _renderObject) =>
      _renderObject..color = color;
}

class _RenderTwoBoxes extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderTwoBoxes(Color color) : _color = color;

  static const _desiredIntrinsicWidth = 200.0;
  static const _desiredIntrinsicHeight = 200.0;

  Color get color => _color;
  Color _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  // @override
  // double computeMinIntrinsicWidth(double height) => _desiredIntrinsicWidth;
  //
  // @override
  // double computeMaxIntrinsicWidth(double height) => _desiredIntrinsicWidth;
  //
  // @override
  // double computeMinIntrinsicHeight(double width) => _desiredIntrinsicHeight;
  //
  // @override
  // double computeMaxIntrinsicHeight(double width) => _desiredIntrinsicHeight;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = 275.0;
    final desiredHeight = 275.0;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void performLayout() {
    final desiredConstraints = computeDryLayout(constraints);
    if (child != null) {
      child!.layout(BoxConstraints.tight(desiredConstraints),
          parentUsesSize: true);
    }
    size = Size(child!.size.width, desiredConstraints.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size > Size.zero) {
      context.canvas.drawRect(offset & size, Paint()..color = color);
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}
