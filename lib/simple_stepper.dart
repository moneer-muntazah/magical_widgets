import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Theme, Colors, Icons;

enum SimpleStepStatus { done, active, stale, canceled }

class _SimpleStepperParentData extends FlexParentData {
  SimpleStepStatus? status;
}

class SimpleStep extends ParentDataWidget<_SimpleStepperParentData> {
  SimpleStep({Key? key, required String label, required this.status})
      : super(key: key, child: _Step(status: status, label: label));

  final SimpleStepStatus status;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is _SimpleStepperParentData);
    final parentData = renderObject.parentData! as _SimpleStepperParentData;
    bool needsPaint = false;

    if (parentData.status != status) {
      parentData.status = status;
      needsPaint = true;
    }

    if (needsPaint) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsPaint();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<SimpleStepStatus>('status', status));
  }
}

class _Step extends StatelessWidget {
  const _Step({Key? key, required this.status, required this.label})
      : super(key: key);

  static double _radius(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.08 / 2;

  final SimpleStepStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final radius = _radius(context);
    final hollow =
        status == SimpleStepStatus.active || status == SimpleStepStatus.stale;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // TODO: Change hard coded color.
            color: hollow ? null : _determineColor(context, status),
            border: hollow
                ? Border.all(
                    color: _determineColor(context, status), width: radius / 5)
                : null,
          ),
          child: _determineChild(radius, status),
        ),
        const SizedBox(height: 3),
        Container(
          height: radius * 4,
          width: radius * 4,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: status == SimpleStepStatus.stale
                    ? SimpleStepper.of(context)?.staleColor
                    : null,
                fontSize: radius * 0.7),
          ),
        )
      ],
    );
  }

  static Color _determineColor(BuildContext context, SimpleStepStatus status) {
    switch (status) {
      case SimpleStepStatus.done:
        return SimpleStepper.of(context)!.doneColor;
      case SimpleStepStatus.active:
        return SimpleStepper.of(context)!.activeColor;
      case SimpleStepStatus.stale:
        return SimpleStepper.of(context)!.staleColor;
      case SimpleStepStatus.canceled:
        return SimpleStepper.of(context)!.canceledColor;
    }
  }

  static Widget? _determineChild(double radius, SimpleStepStatus status) {
    // TODO: Change hard coded color.
    switch (status) {
      case SimpleStepStatus.done:
        return Icon(Icons.done, color: Colors.white, size: radius * 1.5);
      case SimpleStepStatus.canceled:
        return Icon(Icons.close, color: Colors.white, size: radius * 1.5);
      case SimpleStepStatus.active:
      case SimpleStepStatus.stale:
        return null;
    }
  }
}

class SimpleStepper extends Row {
  SimpleStepper(
      {Key? key,
      required this.steps,
      this.mainAxisAlignment = MainAxisAlignment.spaceAround,
      this.doneColor,
      this.activeColor,
      this.staleColor,
      this.canceledColor})
      : super(key: key, children: steps);

  final List<SimpleStep> steps;
  final MainAxisAlignment mainAxisAlignment;
  final Color? doneColor;
  final Color? activeColor;
  final Color? staleColor;
  final Color? canceledColor;

  static _RenderFlexSimpleStepper? of(BuildContext context) =>
      context.findAncestorRenderObjectOfType<_RenderFlexSimpleStepper>();

  @override
  RenderFlex createRenderObject(BuildContext context) =>
      _RenderFlexSimpleStepper(
          textDirection: Directionality.of(context),
          radius: _Step._radius(context),
          mainAxisAlignment: mainAxisAlignment,
          doneColor: doneColor ?? Theme.of(context).primaryColor,
          activeColor: activeColor ?? Theme.of(context).accentColor,
          staleColor: staleColor ?? Theme.of(context).disabledColor,
          canceledColor: canceledColor ?? Theme.of(context).disabledColor);

  @override
  void updateRenderObject(BuildContext context,
          covariant _RenderFlexSimpleStepper renderObject) =>
      renderObject
        ..textDirection = Directionality.of(context)
        ..radius = _Step._radius(context)
        ..mainAxisAlignment = mainAxisAlignment
        ..doneColor = doneColor ?? Theme.of(context).primaryColor
        ..activeColor = activeColor ?? Theme.of(context).accentColor
        ..staleColor = staleColor ?? Theme.of(context).disabledColor
        ..canceledColor = canceledColor ?? Theme.of(context).disabledColor;
}

class _RenderFlexSimpleStepper extends RenderFlex {
  _RenderFlexSimpleStepper(
      {required TextDirection textDirection,
      required double radius,
      required Color doneColor,
      required Color activeColor,
      required Color staleColor,
      required Color canceledColor,
      required MainAxisAlignment mainAxisAlignment})
      : _radius = radius,
        _doneColor = doneColor,
        _activeColor = activeColor,
        _staleColor = staleColor,
        _canceledColor = canceledColor,
        super(
            textDirection: textDirection, mainAxisAlignment: mainAxisAlignment);

  double get radius => _radius;
  double _radius;

  set radius(double value) {
    if (_radius == value) return;
    _radius = value;
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
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SimpleStepperParentData) {
      child.parentData = _SimpleStepperParentData();
    }
  }

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _SimpleStepperParentData;
      final childOffset = childParentData.offset + offset;
      final sibling = childParentData.nextSibling;
      if (sibling != null) {
        final siblingParentData =
            sibling.parentData as _SimpleStepperParentData;
        final siblingOffset = siblingParentData.offset + offset;
        final dy = offset.dy + radius;
        double? dx1 = childOffset.dx + radius * 3;
        double? dx2 = siblingOffset.dx + radius;
        if (textDirection == TextDirection.ltr) {
          dx1 = childOffset.dx + radius * 3;
          dx2 = siblingOffset.dx + radius;
        } else {
          dx1 = childOffset.dx + radius;
          dx2 = siblingOffset.dx + radius * 3;
        }
        final point1 = Offset(dx1, dy);
        final point2 = Offset(dx2, dy);
        context.canvas.drawLine(
            point1, point2, _determinePaint(siblingParentData.status!));
      }
      context.paintChild(child, childOffset);
      child = sibling;
    }
  }

  Paint _determinePaint(SimpleStepStatus status) {
    final strokeWidth = _radius / 5;
    switch (status) {
      case SimpleStepStatus.done:
        return Paint()
          ..color = doneColor
          ..strokeWidth = strokeWidth;
      case SimpleStepStatus.active:
        return Paint()
          ..color = activeColor
          ..strokeWidth = strokeWidth;
      default_paint:
      case SimpleStepStatus.stale:
        return Paint()
          ..color = staleColor
          ..strokeWidth = strokeWidth;
      case SimpleStepStatus.canceled:
        return Paint()
          ..color = canceledColor
          ..strokeWidth = strokeWidth;
      default:
        continue default_paint;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('radius', radius));
    properties.add(ColorProperty('doneColor', doneColor));
    properties.add(ColorProperty('activeColor', activeColor));
    properties.add(ColorProperty('staleColor', staleColor));
    properties.add(ColorProperty('canceledColor', canceledColor));
  }
}
