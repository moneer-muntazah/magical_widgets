import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'flex_simple_step.dart';

export 'flex_simple_step.dart';

class FlexSimpleStepper extends Row {
  FlexSimpleStepper(
      {Key? key,
      required this.steps,
      this.doneColor,
      this.activeColor,
      this.staleColor,
      this.canceledColor})
      : super(key: key, children: steps);

  final List<FlexSimpleStep> steps;
  final Color? doneColor;
  final Color? activeColor;
  final Color? staleColor;
  final Color? canceledColor;

  static _RenderFlexSimpleStepper? of(BuildContext context) =>
      context.findAncestorRenderObjectOfType<_RenderFlexSimpleStepper>();

  @override
  RenderFlex createRenderObject(BuildContext context) =>
      _RenderFlexSimpleStepper(
          steps: steps,
          doneColor: doneColor ?? Theme.of(context).primaryColor,
          activeColor: activeColor ?? Theme.of(context).accentColor,
          staleColor: staleColor ?? Theme.of(context).disabledColor,
          canceledColor: canceledColor ?? Theme.of(context).disabledColor);

  @override
  void updateRenderObject(BuildContext context,
          covariant _RenderFlexSimpleStepper renderObject) =>
      renderObject
        ..steps = steps
        ..doneColor = doneColor ?? Theme.of(context).primaryColor
        ..activeColor = activeColor ?? Theme.of(context).accentColor
        ..staleColor = staleColor ?? Theme.of(context).disabledColor
        ..canceledColor = canceledColor ?? Theme.of(context).disabledColor;
}

class _RenderFlexSimpleStepper extends RenderFlex {
  _RenderFlexSimpleStepper(
      {required List<FlexSimpleStep> steps,
      required Color doneColor,
      required Color activeColor,
      required Color staleColor,
      required Color canceledColor})
      : _steps = steps,
        _doneColor = doneColor,
        _activeColor = activeColor,
        _staleColor = staleColor,
        _canceledColor = canceledColor,
        super(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceAround);

  List<FlexSimpleStep> get steps => _steps;
  List<FlexSimpleStep> _steps;

  set steps(List<FlexSimpleStep> value) {
    if (_steps == value) return;
    _steps = value;
    markNeedsLayout();
  }

  Color get doneColor => _doneColor;
  Color _doneColor;

  set doneColor(Color value) {
    if (_doneColor == value) return;
    _doneColor = value;
    markNeedsPaint();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;

  set activeColor(Color value) {
    if (_activeColor == value) return;
    _activeColor = value;
    markNeedsPaint();
  }

  Color get staleColor => _staleColor;
  Color _staleColor;

  set staleColor(Color value) {
    if (_staleColor == value) return;
    _staleColor = value;
    markNeedsPaint();
  }

  Color get canceledColor => _canceledColor;
  Color _canceledColor;

  set canceledColor(Color value) {
    if (_canceledColor == value) return;
    _canceledColor = value;
    markNeedsPaint();
  }

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    int counter = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      print(steps[counter].status);
      final childParentData = child.parentData! as FlexParentData;
      final childOffset = childParentData.offset + offset;
      final sibling = childParentData.nextSibling;
      if (sibling != null) {
        final siblingParentData = sibling.parentData as FlexParentData;
        final siblingOffset = siblingParentData.offset + offset;
        final point1 = Offset(childOffset.dx + child.size.width / 2,
            childOffset.dy + child.size.width / 2);
        final point2 = Offset(siblingOffset.dx + sibling.size.width / 2,
            siblingOffset.dy + sibling.size.width / 2);
        context.canvas.drawLine(
          point1,
          point2,
          Paint()
            ..color = activeColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0,
        );
      }
      context.paintChild(child, childOffset);
      child = sibling;
      counter++;
    }
  }

// Paint _determinePaint(FlexSimpleStepStatus status) {
//   switch (status) {
//     case FlexSimpleStepStatus.done:
//       return Paint()
//         ..color = doneColor
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.0;
//     case FlexSimpleStepStatus.active:
//       return Paint()
//         ..color = activeColor
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.0;
//     default_paint:
//     case FlexSimpleStepStatus.stale:
//       return Paint()
//         ..color = staleColor
//         ..style = PaintingStyle.fill
//         ..strokeWidth = 2.0;
//     case FlexSimpleStepStatus.canceled:
//       return Paint()
//         ..color = canceledColor
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.0;
//     default:
//       continue default_paint;
//   }
// }
}
