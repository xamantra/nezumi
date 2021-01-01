import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget({
    Key key,
    this.value,
    @required this.items,
    this.onChanged,
    @required this.label,
    this.color,
    this.hint,
    this.selectedItemBuilder,
    this.enabled = true,
  }) : super(key: key);

  final T value;
  final List<T> items;
  final void Function(T) onChanged;
  final String Function(T) label;
  final Color color;
  final String hint;
  final List<String> Function(BuildContext) selectedItemBuilder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return DropdownButton<T>(
          dropdownColor: AppTheme.of(context).primaryBackground,
          underline: SizedBox(),
          value: value,
          hint: Center(
            child: Text(
              hint ?? '',
              style: TextStyle(
                color: AppTheme.of(context).text4,
                fontSize: sy(10),
              ),
            ),
          ),
          iconEnabledColor: color ?? AppTheme.of(context).text4,
          iconDisabledColor: (color ?? AppTheme.of(context).text4).withOpacity(0.4),
          items: items
              .map<DropdownMenuItem<T>>(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    label(item),
                    style: TextStyle(
                      color: color ?? AppTheme.of(context).text4,
                      fontSize: sy(10),
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: selectedItemBuilder == null
              ? null
              : (_) {
                  var list = selectedItemBuilder(_);
                  return list
                      .map<Widget>(
                        (x) => Center(
                          child: Text(
                            x,
                            style: TextStyle(
                              color: color ?? AppTheme.of(context).text4,
                              fontSize: sy(10),
                            ),
                          ),
                        ),
                      )
                      .toList();
                },
          onChanged: !enabled ? null : onChanged ?? (value) {},
        );
      },
    );
  }
}
