import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../mixins/index.dart';
import '../../../components/settings/index.dart';
import '../../../utils/index.dart';
import '../../app-theme.dart';
import '../../index.dart';

class HistoryAnimeSettings extends StatefulWidget {
  const HistoryAnimeSettings({Key key}) : super(key: key);

  @override
  _HistoryAnimeSettingsState createState() => _HistoryAnimeSettingsState();
}

class _HistoryAnimeSettingsState extends MomentumState<HistoryAnimeSettings> with CoreStateMixin {
  TextEditingController episodeGoalController;
  TextEditingController minsGoalController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var episodes = settings.requiredEpsPerDay;
    var minutes = settings.requiredMinsPerEp;
    episodeGoalController = TextEditingController(text: '$episodes');
    minsGoalController = TextEditingController(text: '$minutes');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MomentumBuilder(
            controllers: [SettingsController],
            builder: (context, snapshot) {
              return Container(
                width: width,
                padding: EdgeInsets.all(sy(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Daily Episode Goal',
                      style: TextStyle(
                        fontSize: sy(14),
                        fontWeight: FontWeight.w500,
                        color: AppTheme.of(context).text3,
                      ),
                    ),
                    SizedBox(height: sy(8)),
                    EditFieldInfoRow(
                      label: 'Episodes per day',
                      child: SizedBox(
                        height: sy(24),
                        width: sy(30),
                        child: TextFormField(
                          maxLines: 1,
                          controller: episodeGoalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.of(context).accent,
                            fontSize: sy(10),
                          ),
                          onChanged: (value) {
                            var episodes = trycatch(() => int.parse(value), null);
                            settings.update(requiredEpsPerDay: episodes);
                          },
                        ),
                      ),
                    ),
                    EditFieldInfoRow(
                      label: 'Minutes per episode',
                      child: SizedBox(
                        height: sy(24),
                        width: sy(30),
                        child: TextFormField(
                          maxLines: 1,
                          controller: minsGoalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.of(context).accent,
                            fontSize: sy(10),
                          ),
                          onChanged: (value) {
                            var minutes = trycatch(() => int.parse(value), null);
                            settings.update(requiredMinsPerEp: minutes);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
