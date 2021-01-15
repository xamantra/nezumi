import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/index.dart';
import '../../../mixins/index.dart';
import '../../index.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({Key key, @required this.history}) : super(key: key);

  final AnimeHistory history;

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> with CoreStateMixin {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        String ago;
        var diff = DateTime.now().difference(widget.history.timestamp).abs();
        if (diff.inHours <= 12) {
          ago = timeago.format(widget.history.timestamp);
        } else {
          ago = DateFormat('MMM dd, h:mm a').format(widget.history.timestamp);
        }
        return Column(
          children: [
            FlatButton(
              onPressed: () {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  widget.history.title,
                  style: TextStyle(
                    color: AppTheme.of(context).text3,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'Episode ${widget.history.episode}',
                      style: TextStyle(
                        color: AppTheme.of(context).text5,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                    Dot(color: AppTheme.of(context).text5),
                    Text(
                      ago,
                      style: TextStyle(
                        color: AppTheme.of(context).text5,
                        fontWeight: FontWeight.w300,
                        fontSize: sy(7),
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  '${widget.history.durationMins} mins.',
                  style: TextStyle(
                    color: AppTheme.of(context).text5,
                    fontWeight: FontWeight.w400,
                    fontSize: sy(8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                dense: true,
              ),
            ),
            Divider(height: 1),
          ],
        );
      },
    );
  }
}
