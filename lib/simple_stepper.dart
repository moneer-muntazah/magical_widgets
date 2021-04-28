import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Theme, Colors, Icons;

/// These are the states that the nodes represent
/// [SimpleStepState.active], [SimpleStepState.stale], and
/// [SimpleStepState.skip] are hollowed- have no icons.
/// [SimpleStepper] have color properties that correspond to these states,
/// and use the same naming convention.
enum SimpleStepState { done, active, stale, canceled, skip }

/// Used in order to have access to the states that the nodes represent during
/// the painting process. We have to extend [FlexParentData] because it is
/// the class used by [RenderFlex].
class SimpleStepperParentData extends FlexParentData {
  SimpleStepState? state;
}

/// Similar to [Flexible], this is the class exposed to the user. It wraps
/// [SimpleStepNode] and applies [ParentData].
class SimpleStep extends ParentDataWidget<SimpleStepperParentData> {
  SimpleStep(
      {Key? key,
      this.flex = 1,
      this.fit = FlexFit.loose,
      required String label,
      required this.state})
      : super(key: key, child: SimpleStepNode(state: state, label: label));

  final int flex;
  final FlexFit fit;
  final SimpleStepState state;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is SimpleStepperParentData);
    final parentData = renderObject.parentData as SimpleStepperParentData;
    var needsLayout = false;
    var needsPaint = false;

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (parentData.fit != fit) {
      parentData.fit = fit;
      needsLayout = true;
    }

    if (parentData.state != state) {
      parentData.state = state;
      needsPaint = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsLayout();
    } else if (needsPaint) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsPaint();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<SimpleStepState>('state', state));
  }
}

/// This is the actual widget that describes every step. If you need to modify
/// the UI, this is where you most likely going to work.
class SimpleStepNode extends StatelessWidget {
  const SimpleStepNode(
      {Key? key,
      required this.state,
      required this.label,
      this.iconColor = Colors.white})
      : super(key: key);

  /// This is the function which the proportionality of the design is based on.
  static double radius(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.035;

  /// The state that the node represents.
  final SimpleStepState state;

  /// The text shown under the node
  final String label;

  /// If the node has an icon, this property defines its color.
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final r = radius(context);
    final diameter = r * 2;
    final hollow = <SimpleStepState>[
      SimpleStepState.active,
      SimpleStepState.stale,
      SimpleStepState.skip
    ].contains(state);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: diameter,
          width: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hollow ? null : _determineColor(context, state),
            border: hollow
                ? Border.all(
                    color: _determineColor(context, state), width: r / 7)
                : null,
          ),
          child: _determineChild(context, state),
        ),
        const SizedBox(height: 5),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: diameter * 3),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: state == SimpleStepState.stale
                    ? SimpleStepper.of(context)?.staleColor
                    : null,
                fontSize: r * 0.8),
          ),
        )
      ],
    );
  }

  Color _determineColor(BuildContext context, SimpleStepState state) {
    switch (state) {
      case SimpleStepState.done:
        return SimpleStepper.of(context)!.doneColor;
      case SimpleStepState.active:
        return SimpleStepper.of(context)!.activeColor;
      case SimpleStepState.stale:
        return SimpleStepper.of(context)!.staleColor;
      case SimpleStepState.canceled:
        return SimpleStepper.of(context)!.canceledColor;
      case SimpleStepState.skip:
        return SimpleStepper.of(context)!.skipColor;
    }
  }

  Widget? _determineChild(BuildContext context, SimpleStepState state) {
    double iconSize() => radius(context) * 1.5;
    switch (state) {
      case SimpleStepState.done:
        return Icon(Icons.done, color: iconColor, size: iconSize());
      case SimpleStepState.canceled:
        return Icon(Icons.close, color: iconColor, size: iconSize());
      case SimpleStepState.active:
      case SimpleStepState.stale:
      case SimpleStepState.skip:
        return null;
    }
  }
}

/// [SimpleStepper] is our [MultiChildRenderObjectWidget]. The [Row] widget
/// has most of the default behavior we need so we extend it, and add the
/// additional properties that will later be passed to
/// [_RenderFlexSimpleStepper]
class SimpleStepper extends Row {
  SimpleStepper(
      {Key? key,
      required List<SimpleStep> steps,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.doneColor,
      this.activeColor,
      this.staleColor,
      this.canceledColor,
      this.skipColor})
      : super(key: key, children: steps, mainAxisAlignment: mainAxisAlignment);

  final Color? doneColor;
  final Color? activeColor;
  final Color? staleColor;
  final Color? canceledColor;
  final Color? skipColor;

  /// Used so that [SimpleStepNode] can have access to the color properties
  /// set in [_RenderFlexSimpleStepper].
  static _RenderFlexSimpleStepper? of(BuildContext context) =>
      context.findAncestorRenderObjectOfType<_RenderFlexSimpleStepper>();

  @override
  RenderFlex createRenderObject(BuildContext context) =>
      _RenderFlexSimpleStepper(
          textDirection: Directionality.of(context),
          radius: SimpleStepNode.radius(context),
          mainAxisAlignment: mainAxisAlignment,
          doneColor: doneColor ?? Theme.of(context).primaryColor,
          activeColor: activeColor ?? Theme.of(context).accentColor,
          staleColor: staleColor ?? Theme.of(context).disabledColor,
          canceledColor: canceledColor ?? Theme.of(context).primaryColor,
          skipColor: skipColor ?? Theme.of(context).primaryColor);

  @override
  void updateRenderObject(BuildContext context,
          covariant _RenderFlexSimpleStepper renderObject) =>
      renderObject
        ..textDirection = Directionality.of(context)
        ..radius = SimpleStepNode.radius(context)
        ..mainAxisAlignment = mainAxisAlignment
        ..doneColor = doneColor ?? Theme.of(context).primaryColor
        ..activeColor = activeColor ?? Theme.of(context).accentColor
        ..staleColor = staleColor ?? Theme.of(context).disabledColor
        ..canceledColor = canceledColor ?? Theme.of(context).primaryColor
        ..skipColor = skipColor ?? Theme.of(context).primaryColor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('doneColor', doneColor));
    properties.add(ColorProperty('activeColor', activeColor));
    properties.add(ColorProperty('staleColor', staleColor));
    properties.add(ColorProperty('canceledColor', canceledColor));
    properties.add(ColorProperty('skipColor', skipColor));
  }
}

/// [_RenderFlexSimpleStepper] is our [RenderObject]. [RenderFlex] is
/// convenient to subclass since it has most of behavior we need.
class _RenderFlexSimpleStepper extends RenderFlex {
  _RenderFlexSimpleStepper(
      {required TextDirection textDirection,
      required MainAxisAlignment mainAxisAlignment,
      required double radius,
      required Color doneColor,
      required Color activeColor,
      required Color staleColor,
      required Color canceledColor,
      required Color skipColor})
      : _radius = radius,
        _doneColor = doneColor,
        _activeColor = activeColor,
        _staleColor = staleColor,
        _canceledColor = canceledColor,
        _skipColor = skipColor,
        super(
            textDirection: textDirection,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start);

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

  Color get skipColor => _skipColor;
  Color _skipColor;

  set skipColor(Color value) {
    if (_skipColor == value) return;
    _skipColor = value;
    markNeedsPaint();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! SimpleStepperParentData) {
      child.parentData = SimpleStepperParentData();
    }
  }

  /// [defaultPaint] is called the overridden paint method in [RenderFlex].
  /// We override in order to paint the lines in between our nodes.
  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as SimpleStepperParentData;
      final childOffset = childParentData.offset + offset;
      final sibling = childParentData.nextSibling;
      if (sibling != null) {
        final siblingParentData = sibling.parentData as SimpleStepperParentData;
        final siblingOffset = siblingParentData.offset + offset;
        final dy = offset.dy + radius;
        double dx1;
        double dx2;
        double start(w) => w / 2 + radius;
        double end(w) => w / 2 - radius;
        if (textDirection == TextDirection.ltr) {
          dx1 = childOffset.dx + start(child.size.width);
          dx2 = siblingOffset.dx + end(sibling.size.width);
        } else {
          dx1 = childOffset.dx + end(child.size.width);
          dx2 = siblingOffset.dx + start(sibling.size.width);
        }
        final point1 = Offset(dx1, dy);
        final point2 = Offset(dx2, dy);
        context.canvas.drawLine(
            point1, point2, _determinePaint(siblingParentData.state!));
      }
      context.paintChild(child, childOffset);
      child = sibling;
    }
  }

  Paint _determinePaint(SimpleStepState state) {
    final strokeWidth = _radius / 7;
    switch (state) {
      case SimpleStepState.done:
        return Paint()
          ..color = doneColor
          ..strokeWidth = strokeWidth;
      case SimpleStepState.active:
        return Paint()
          ..color = activeColor
          ..strokeWidth = strokeWidth;
      case SimpleStepState.stale:
        return Paint()
          ..color = staleColor
          ..strokeWidth = strokeWidth;
      case SimpleStepState.canceled:
        return Paint()
          ..color = canceledColor
          ..strokeWidth = strokeWidth;
      case SimpleStepState.skip:
        return Paint()
          ..color = skipColor
          ..strokeWidth = strokeWidth;
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
    properties.add(ColorProperty('skipColor', skipColor));
  }
}
