import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../index.dart';

class SelectionToolWidget extends StatefulWidget {
  const SelectionToolWidget({
    Key key,
    @required this.actionIcon,
    @required this.actionSize,
    @required this.actionTooltip,
    @required this.onActionCallback,
    @required this.onSelectAbove,
    @required this.onSelectBelow,
  }) : super(key: key);

  final IconData actionIcon;
  final double actionSize;
  final String actionTooltip;
  final void Function() onActionCallback;
  final void Function() onSelectAbove;
  final void Function() onSelectBelow;

  @override
  _SelectionToolWidgetState createState() => _SelectionToolWidgetState();
}

class _SelectionToolWidgetState extends State<SelectionToolWidget> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return MomentumBuilder(
          builder: (context, snapshot) {
            var onlyOneSelectd = animeTop.selectedAnimeIDs.length == 1;
            var selectedAnimeId = -1;
            if (onlyOneSelectd) {
              selectedAnimeId = animeTop.selectedAnimeIDs.first;
            }

            return !animeTop.selectionMode
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.all(sy(8)),
                    padding: EdgeInsets.all(sy(6)),
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Badge(
                          color: AppTheme.of(context).accent,
                          textColor: Colors.white,
                          text: '${animeTop.selectedAnimeIDs.length} ',
                          fontSize: sy(11),
                          borderRadius: 100,
                        ),
                        Spacer(),
                        !onlyOneSelectd
                            ? SizedBox()
                            : SizedButton(
                                height: sy(24),
                                width: sy(40),
                                radius: 100,
                                tooltip: 'Select all above',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: sy(12),
                                      color: AppTheme.of(context).accent,
                                    ),
                                    Icon(
                                      Icons.check,
                                      size: sy(12),
                                      color: AppTheme.of(context).accent,
                                    ),
                                  ],
                                ),
                                onPressed: widget.onSelectAbove,
                              ),
                        !onlyOneSelectd
                            ? SizedBox()
                            : SizedButton(
                                height: sy(24),
                                width: sy(40),
                                radius: 100,
                                tooltip: 'Select all below',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: sy(12),
                                      color: AppTheme.of(context).accent,
                                    ),
                                    Icon(
                                      Icons.check,
                                      size: sy(12),
                                      color: AppTheme.of(context).accent,
                                    ),
                                  ],
                                ),
                                onPressed: widget.onSelectBelow,
                              ),
                        SizedBox(width: sy(onlyOneSelectd ? 4 : 0)),
                        SizedButton(
                          height: sy(24),
                          width: sy(30),
                          radius: 100,
                          tooltip: widget.actionTooltip,
                          child: Icon(
                            widget.actionIcon,
                            size: widget.actionSize,
                            color: AppTheme.of(context).accent,
                          ),
                          onPressed: widget.onActionCallback,
                        ),
                        Spacer(),
                        SizedButton(
                          height: sy(24),
                          width: sy(24),
                          radius: 100,
                          child: Icon(
                            Icons.close,
                            size: sy(14),
                          ),
                          onPressed: () {
                            animeTop.controller.clearSelection();
                          },
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
