/// Credit: https://medium.com/flutter-community/creating-a-flutter-widget-from-scratch-a9c01c47c630
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class ProgressBarSingleChild extends SingleChildRenderObjectWidget {
  const ProgressBarSingleChild(
      {Key? key, required Widget child, required this.barColor})
      : super(key: key, child: child);

  final Color barColor;

  @override
  _RenderProgressBarSingleChild createRenderObject(BuildContext context) =>
      _RenderProgressBarSingleChild(barColor: barColor);

  @override
  void updateRenderObject(
          BuildContext context, _RenderProgressBarSingleChild renderObject) =>
      renderObject..barColor = barColor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
  }
}

class _RenderProgressBarSingleChild extends RenderProxyBox {
  _RenderProgressBarSingleChild({RenderBox? child, required Color barColor})
      : _barColor = barColor,
        super(child);

  Color get barColor => _barColor;
  Color _barColor;

  set barColor(Color value) {
    if (_barColor == value) return;
    _barColor = value;
    markNeedsPaint();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = 50.0;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
    }
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);

    if (child != null) {
      context.paintChild(
          child!,
          Offset(size.width / 2 - child!.size.width / 2,
              size.height / 2 - child!.size.width / 2));
    }

    final barPaint = Paint()
      ..color = barColor
      ..strokeWidth = 5;
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(size.width, size.height / 2);
    context.canvas.drawLine(point1, point2, barPaint);

    context.canvas.restore();
  }
}
