import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

import '../absract/index.dart';
import 'index.dart';

class AnimeFilterItemWidget extends StatefulWidget {
  const AnimeFilterItemWidget({
    Key key,
    @required this.filterItem,
  }) : super(key: key);

  final AnimeFilterItemBase filterItem;

  @override
  _AnimeFilterItemWidgetState createState() => _AnimeFilterItemWidgetState();
}

class _AnimeFilterItemWidgetState extends State<AnimeFilterItemWidget> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Card(
          color: AppTheme.of(context).secondaryBackground,
          margin: EdgeInsets.symmetric(horizontal: sy(8), vertical: sy(4)),
          child: Stack(
            children: [
              Ripple(
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(sy(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.filterItem.title,
                        style: TextStyle(
                          color: AppTheme.of(context).text2,
                          fontSize: sy(10),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      widget.filterItem.build(context),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedButton(
                  height: sy(20),
                  width: sy(20),
                  radius: 100,
                  child: Icon(
                    Icons.close,
                    size: sy(14),
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    widget.filterItem.onRemoveCallback(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
