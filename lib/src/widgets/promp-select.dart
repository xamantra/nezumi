import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../utils/index.dart';
import 'index.dart';

Future<List<T>> selectFrom<T>(
  BuildContext context, {
  @required List<T> source,
  List<T> defaults,
  @required String Function(T) label,
  bool Function(T) matcher,
}) async {
  var result = await dialog<List<T>>(
    context,
    _PrompSelect<T>(
      source: source,
      defaults: defaults,
      label: label,
      matcher: matcher,
    ),
  );
  return result;
}

class _PrompSelect<T> extends StatefulWidget {
  const _PrompSelect({
    Key key,
    @required this.source,
    this.defaults = const [],
    @required this.label,
    @required this.matcher,
  }) : super(key: key);

  final List<T> source;
  final List<T> defaults;
  final String Function(T) label;
  final bool Function(T) matcher;

  @override
  __PrompSelectState<T> createState() => __PrompSelectState<T>();
}

class __PrompSelectState<T> extends State<_PrompSelect<T>> {
  List<T> selected = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selected = widget.defaults;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          var list = <Widget>[];
          for (var i = 0; i < widget.source.length; i++) {
            var item = widget.source[i];
            list.add(
              _PromptListItemWidget(
                label: widget.label(item),
                selected: selected.any(widget.matcher ?? (x) => x == item),
                onChanged: (value) {
                  if (!value) {
                    // remove
                    setState(() {
                      selected.removeWhere(widget.matcher ?? (x) => x == item);
                    });
                  } else {
                    //add
                    setState(() {
                      selected.add(item);
                    });
                  }
                },
              ),
            );
            if (i != (widget.source.length - 1)) {
              list.add(Divider(height: 1, color: Colors.white.withOpacity(0.1)));
            }
          }

          return Container(
            width: width,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: list,
                  ),
                ),
                SizedButton(
                  height: sy(36),
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OK',
                        style: TextStyle(
                          fontSize: sy(10),
                          color: AppTheme.of(context).accent,
                        ),
                      ),
                      SizedBox(width: sy(2)),
                      Icon(
                        Icons.check,
                        size: sy(12),
                        color: AppTheme.of(context).accent,
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await Navigator.pop(context, selected);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PromptListItemWidget extends StatelessWidget {
  const _PromptListItemWidget({
    Key key,
    @required this.label,
    @required this.selected,
    @required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Ripple(
      child: Column(
        children: [
          RelativeBuilder(
            builder: (context, height, width, sy, sx) {
              return ListTile(
                title: Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.of(context).text2,
                    fontSize: sy(10),
                  ),
                ),
                trailing: Checkbox(
                  value: selected,
                  onChanged: onChanged,
                  activeColor: AppTheme.of(context).primary,
                ),
              );
            },
          ),
        ],
      ),
      onPressed: () {
        onChanged(!selected);
      },
    );
  }
}
