/// Credit: https://nicksnettravels.builttoroam.com/create-a-flutter-widget/
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';

class Tint extends SingleChildRenderObjectWidget {
  const Tint({Key? key, required this.color, required Widget child})
      : super(key: key, child: child);

  final Color color;

  @override
  _RenderTint createRenderObject(BuildContext context) =>
      _RenderTint(color: color);

  @override
  void updateRenderObject(BuildContext context, _RenderTint renderObject) =>
      renderObject..color = color;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}

class _RenderTint extends RenderProxyBox {
  _RenderTint({Color color = const Color(0x00000000), RenderBox? child})
      : _color = color,
        super(child);

  Color get color => _color;
  Color _color;

  set color(Color color) {
    if (_color == color) return;
    _color = color;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child!, offset);
    }
    context.canvas.drawColor(color, BlendMode.srcOver);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}
