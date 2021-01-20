import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import 'index.dart';

class Paginator extends StatefulWidget {
  const Paginator({
    Key key,
    @required this.currentPage,
    @required this.prevEnabled,
    @required this.nextEnabled,
    @required this.onPrev,
    @required this.onNext,
  }) : super(key: key);

  final int currentPage;
  final bool prevEnabled;
  final bool nextEnabled;
  final void Function() onPrev;
  final void Function() onNext;

  @override
  _PaginatorState createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedButton(
              height: sy(36),
              width: sy(36),
              radius: 100,
              enabled: widget.prevEnabled,
              child: Icon(
                Icons.chevron_left,
                size: sy(20),
                color: AppTheme.of(context).accent,
              ),
              onPressed: widget.onPrev,
            ),
            Text(
              '${widget.currentPage}',
              style: TextStyle(
                color: AppTheme.of(context).accent,
                fontSize: sy(12),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedButton(
              height: sy(36),
              width: sy(36),
              radius: 100,
              enabled: widget.nextEnabled,
              child: Icon(
                Icons.chevron_right,
                size: sy(20),
                color: AppTheme.of(context).accent,
              ),
              onPressed: widget.onNext,
            ),
          ],
        );
      },
    );
  }
}
