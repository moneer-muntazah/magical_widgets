import 'package:flutter/foundation.dart';
/// Source: https://medium.com/flutter-community/creating-a-flutter-widget-from-scratch-a9c01c47c630
import 'package:flutter/widgets.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({Key key, @required this.barColor, @required this.thumbColor,
  this.thumbSize = 20.0}) : super(key: key);

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderProgressBar renderObject) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderProgressBar extends RenderBox {

  static const _minDesiredWidth = 100.0;

  RenderProgressBar({
    @required Color barColor,
    @required Color thumbColor,
    @required double thumbSize
}) : _barColor = barColor, _thumbColor = thumbColor,
  _thumbSize = thumbSize;

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

  //@override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

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
}