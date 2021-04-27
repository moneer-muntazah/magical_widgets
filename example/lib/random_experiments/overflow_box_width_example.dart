import 'package:flutter/material.dart';
import 'package:magical_widgets/magical_widgets.dart' show OverflowBoxWidth;

const text = 'Hello World';

class OverflowBoxWidthExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return _Issue();
    return _Solution();
  }
}

class _Issue extends StatelessWidget {
  const _Issue({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: Colors.amber,
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 50, minWidth: 50, maxHeight: 50),
          child: OverflowBox(
            maxWidth: 80,
            child: Text(
              text,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _Solution extends StatelessWidget {
  const _Solution({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: Colors.amber,
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(height: 50, width: 50),
          child: OverflowBoxWidth(
            maxWidth: 80,
            child: Text(
              text,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
