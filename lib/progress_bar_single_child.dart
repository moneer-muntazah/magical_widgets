import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart' show Colors;

class ProgressBarSingleChild extends SingleChildRenderObjectWidget {
  const ProgressBarSingleChild(
      {Key? key,
      required this.child,
      required this.barColor})
      : super(key: key, child: child);

  final Widget child;
  final Color barColor;

  @override
  _RenderProgressBarSingleChild createRenderObject(BuildContext context) =>
      _RenderProgressBarSingleChild(
          barColor: barColor);

  @override
  void updateRenderObject(
          BuildContext context, _RenderProgressBarSingleChild renderObject) =>
      renderObject
        ..barColor = barColor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
  }
}

class _RenderProgressBarSingleChild extends RenderProxyBox {
  static const _minDesiredWidth = 100.0;

  _RenderProgressBarSingleChild(
      {RenderBox? child, required Color barColor})
      : _barColor = barColor, super(child);

  Color get barColor => _barColor;
  Color _barColor;

  set barColor(Color value) {
    if (_barColor == value) return;
    _barColor = value;
    markNeedsPaint();
  }

  double _currentThumbValue = 0.5;

  // @override
  // double computeMinIntrinsicWidth(double height) => _minDesiredWidth;
  //
  // @override
  // double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;
  //
  // @override
  // double computeMinIntrinsicHeight(double width) => 50.0;
  //
  // @override
  // double computeMaxIntrinsicHeight(double width) => 50.0;

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    // final desiredWidth = constraints.maxWidth;
    // final desiredHeight = 50.0;
    // final desiredSize = Size(desiredWidth, desiredHeight);
    // return constraints.constrain(desiredSize);
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    final barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 5;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width, size.height / 2);
    canvas.drawLine(point1, point2, barPaint);
    context.paintChild(child!, point1);
    context.canvas.drawColor(Colors.transparent, BlendMode.srcOver);
    canvas.restore();
  }
}
