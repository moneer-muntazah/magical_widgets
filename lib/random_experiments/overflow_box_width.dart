import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OverflowBoxWidth extends SingleChildRenderObjectWidget {
  const OverflowBoxWidth(
      {Key? key, this.minWidth, this.maxWidth, Widget? child})
      : super(key: key, child: child);

  final double? minWidth;
  final double? maxWidth;

  @override
  _RenderConstrainedOverflowBoxWidth createRenderObject(BuildContext context) =>
      _RenderConstrainedOverflowBoxWidth(
          minWidth: minWidth,
          maxWidth: maxWidth,
          textDirection: Directionality.maybeOf(context));

  @override
  void updateRenderObject(
      BuildContext context, _RenderConstrainedOverflowBoxWidth renderObject) {
    renderObject
      ..minWidth = minWidth
      ..maxWidth = maxWidth
      ..textDirection = Directionality.maybeOf(context);
  }
}

class _RenderConstrainedOverflowBoxWidth extends RenderConstrainedOverflowBox {
  _RenderConstrainedOverflowBoxWidth(
      {double? minWidth, double? maxWidth, TextDirection? textDirection})
      : super(
            minWidth: minWidth,
            maxWidth: maxWidth,
            alignment: Alignment.center,
            textDirection: textDirection);

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size(
        constraints.maxWidth, constraints.minHeight);
  }
}
