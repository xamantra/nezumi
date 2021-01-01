import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../utils/index.dart';
import '../../index.dart';

class AnimeEditDateSelection extends StatefulWidget {
  const AnimeEditDateSelection({
    Key key,
    @required this.label,
    this.value = '',
    this.onChanged,
    this.enabled = true,
    this.dense = false,
    this.verticalPadding = 0,
  }) : super(key: key);

  final String label;
  final String value;
  final bool enabled;
  final bool dense;
  final double verticalPadding;

  /// Date changed callback (`year`, `month`, `day`)
  final void Function(String) onChanged;

  @override
  _AnimeEditDateSelectionState createState() => _AnimeEditDateSelectionState();
}

class _AnimeEditDateSelectionState extends State<AnimeEditDateSelection> {
  int selectedYear = 0;
  int selectedMonth = 0;
  int selectedDay = 0;

  bool get validYear => selectedYear != null && selectedYear != 0;
  bool get validMonth => selectedMonth != null && selectedMonth != 0;
  bool get validDay => selectedDay != null && selectedDay != 0;

  List<String> get valuesRaw => widget.value?.split('-') ?? ['0', '0', '0'];
  List<int> get values => trycatch(() => valuesRaw.map<int>((e) => parseInt(e)).toList(), [0, 0, 0]);
  int get yearValue => trycatch(() => values[0]);
  int get monthValue => trycatch(() => values[1]);
  int get dayValue => trycatch(() => values[2]);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedYear = yearValue;
    selectedMonth = monthValue;
    selectedDay = dayValue;
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        var months = getMonths();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 0),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: sy(10),
                  color: AppTheme.of(context).text3,
                ),
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownWidget<int>(
                    value: selectedYear,
                    hint: '----',
                    label: (item) => item == 0 ? '----' : item.toString(),
                    items: [0]..addAll(yearList),
                    color: AppTheme.of(context).accent,
                    enabled: widget.enabled,
                    dense: widget.dense,
                    onChanged: (year) {
                      setState(() {
                        selectedYear = year;
                        callback();
                      });
                    },
                  ),
                  DropdownWidget<int>(
                    value: selectedMonth,
                    hint: '--',
                    label: (item) {
                      return months[item];
                    },
                    items: months.keys.toList(),
                    selectedItemBuilder: (_) {
                      return months.keys.map<String>((x) => x == 0 ? '--' : x.toString().padLeft(2, '0')).toList();
                    },
                    color: AppTheme.of(context).accent,
                    enabled: widget.enabled,
                    dense: widget.dense,
                    onChanged: (month) {
                      setState(() {
                        selectedMonth = month;
                        callback();
                      });
                    },
                  ),
                  DropdownWidget<int>(
                    value: selectedDay,
                    hint: '--',
                    label: (item) => item == 0 ? '--' : item.toString().padLeft(2, '0'),
                    items: getDays(),
                    color: AppTheme.of(context).accent,
                    enabled: widget.enabled,
                    dense: widget.dense,
                    onChanged: (day) {
                      setState(() {
                        selectedDay = day;
                        callback();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void callback() {
    if (!validYear) {
      setState(() {
        selectedMonth = 0;
        selectedDay = 0;
      });
    } else if (validYear && !validMonth) {
      setState(() {
        selectedDay = 0;
      });
    } else if (!validYear && validMonth) {
      setState(() {
        selectedYear = 0;
      });
    }
    if (widget.onChanged != null) {
      var y = selectedYear == 0 ? '' : selectedYear?.toString() ?? '';
      var m = selectedMonth == 0 ? '' : selectedMonth?.toString() ?? '';
      var d = selectedDay == 0 ? '' : selectedDay?.toString() ?? '';
      var value = '';
      if (y.isNotEmpty) {
        value += y;
      }
      if (m.isNotEmpty) {
        value += '-${m.padLeft(2, "0")}';
      }
      if (d.isNotEmpty) {
        value += '-${d.padLeft(2, "0")}';
      }
      widget.onChanged(value);
    }
  }

  List<int> getDays() {
    try {
      var dateUtility = DateUtil();
      var days = dateUtility.daysInMonth(selectedMonth, selectedYear);
      var result = <int>[];
      for (var i = 0; i < days; i++) {
        result.add(i + 1);
      }
      result.insert(0, 0);
      return result;
    } catch (e) {
      return [];
    }
  }

  Map<int, String> getMonths() {
    try {
      if (!validYear) {
        return {};
      }
      return monthListMMM;
    } catch (e) {
      return {};
    }
  }

  int parseInt(String source) {
    return trycatch(() => int.parse(source));
  }
}
