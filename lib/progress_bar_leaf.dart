/// Credit: https://medium.com/flutter-community/creating-a-flutter-widget-from-scratch-a9c01c47c630
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ProgressBarLeaf extends LeafRenderObjectWidget {
  const ProgressBarLeaf(
      {Key? key,
      required this.barColor,
      required this.thumbColor,
      this.thumbSize = 20.0})
      : super(key: key);

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;

  @override
  _RenderProgressBarLeaf createRenderObject(BuildContext context) =>
      _RenderProgressBarLeaf(
          barColor: barColor, thumbColor: thumbColor, thumbSize: thumbSize);

  @override
  void updateRenderObject(
      BuildContext context, _RenderProgressBarLeaf renderObject) =>
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class _RenderProgressBarLeaf extends RenderBox {
  _RenderProgressBarLeaf(
      {required Color barColor,
      required Color thumbColor,
      required double thumbSize})
      : _barColor = barColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize;

  static const _minDesiredWidth = 100.0;

  Color get barColor => _barColor;
  Color _barColor;

  set barColor(Color value) {
    if (_barColor == value) return;
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;

  set thumbColor(Color value) {
    if (_thumbColor == value) return;
    _thumbColor = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  double _thumbSize;

  set thumbSize(double value) {
    if (_thumbSize == value) return;
    _thumbSize = value;
    markNeedsLayout();
  }

  final _currentThumbValue = 0.5;

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => _thumbSize;

  @override
  double computeMaxIntrinsicHeight(double width) => thumbSize;

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
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

    final thumbPaint = Paint()..color = thumbColor;
    final thumbDx = _currentThumbValue * size.width;
    final center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbSize / 2, thumbPaint);

    canvas.restore();
  }
}
