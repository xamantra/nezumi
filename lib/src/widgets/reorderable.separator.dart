import 'package:flutter/material.dart';

class ReorderableSeparator extends StatelessWidget {
  const ReorderableSeparator({
    Key key,
    @required this.children,
    @required this.onReorder,
    @required this.separator,
  })  : assert(children != null),
        assert(onReorder != null),
        assert(separator != null),
        super(key: key);

  final void Function(int, int) onReorder;
  final List<Widget> children;
  final Widget separator;

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i != (children.length - 1)) {
        widgets.add(Column(
          key: Key('_child(${children[i].key})'),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            children[i],
            separator,
          ],
        ));
      } else {
        widgets.add(children[i]);
      }
    }
    return ReorderableListView(
      children: widgets,
      onReorder: onReorder ?? (oldIndex, newIndex) {},
    );
  }
}
