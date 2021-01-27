import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../../components/anime-update/index.dart';
import '../../../mixins/index.dart';
import '../../../utils/index.dart';
import '../../index.dart';
import 'index.dart';

class EditAnimeDialog extends StatefulWidget {
  const EditAnimeDialog({Key key}) : super(key: key);

  @override
  _EditAnimeGlobalDialogState createState() => _EditAnimeGlobalDialogState();
}

class _EditAnimeGlobalDialogState extends MomentumState<EditAnimeDialog> with CoreStateMixin {
  TextEditingController rewatchTextController;
  TextEditingController episodesTextController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var rewatched = animeUpdate.currentInput?.numTimesRewatched?.toString();
    var episodes = animeUpdate.currentInput?.numEpisodesWatched?.toString();
    rewatchTextController = TextEditingController(text: rewatched);
    episodesTextController = TextEditingController(text: episodes);
    animeUpdate.controller.listen<AnimeUpdateRewatchEvent>(
      state: this,
      invoke: (event) {
        rewatchTextController.text = event.value?.toString();
      },
    );
    animeUpdate.controller.listen<AnimeUpdateEpisodesEvent>(
      state: this,
      invoke: (event) {
        episodesTextController.text = event.value?.toString();
      },
    );
    animeUpdate.controller.listen<AnimeUpdateError>(
      state: this,
      invoke: (event) {
        showToast(
          event.message,
          fontSize: 14,
          color: Colors.red[600],
        );
      },
    );
    animeUpdate.controller.listen<AnimeFailedToloadError>(
      state: this,
      invoke: (event) async {
        await Navigator.pop(context);
        showToast(
          event.message,
          fontSize: 14,
          color: Colors.red[600],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: RelativeBuilder(
        builder: (context, height, width, sy, sx) {
          return MomentumBuilder(
            controllers: [AnimeUpdateController],
            builder: (context, snapshot) {
              var controller = animeUpdate.controller;
              var anime = animeUpdate.animeDetails;
              var currentInput = animeUpdate.currentInput;
              var status = currentInput?.status;
              var currentAnimeId = animeUpdate.animeDetails?.id;
              var loading = animeUpdate.loading;
              var canEditStartDate = status != 'plan_to_watch';
              var canEditFinishDate = status == 'completed' || status == 'dropped';
              var canEditRewatching = status == 'completed';
              var notInMyList = !mal.controller.inMyList(anime?.id ?? -1);

              return Container(
                padding: EdgeInsets.all(sy(8)),
                width: width,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      animeUpdate?.title ?? '',
                      style: TextStyle(
                        color: AppTheme.of(context).text3,
                        fontWeight: FontWeight.w600,
                        fontSize: sy(12),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sy(8)),
                    loading
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(sy(8)),
                              child: SizedBox(
                                height: sy(30),
                                width: sy(30),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              EditFieldInfoRow(
                                label: 'Status',
                                verticalPadding: sy(4),
                                child: DropdownWidget<String>(
                                  value: currentInput?.status ?? 'completed',
                                  label: (item) => normalizeSlug(item),
                                  items: allAnimeStatusList,
                                  dense: true,
                                  color: AppTheme.of(context).accent,
                                  onChanged: (newStatus) {
                                    controller.editStatus(newStatus);
                                  },
                                ),
                              ),
                              !canEditRewatching
                                  ? SizedBox()
                                  : EditFieldInfoRow(
                                      label: 'Rewatching',
                                      child: Checkbox(
                                        value: currentInput?.isRewatching ?? false,
                                        activeColor: AppTheme.of(context).accent,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (isRewatching) {
                                          controller.editIsRewatching(isRewatching);
                                        },
                                      ),
                                    ),
                              // Divider(height: 1, color: AppTheme.of(context).text7),
                              EditFieldInfoRow(
                                label: 'Episodes',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedButton(
                                      height: sy(24),
                                      width: sy(24),
                                      radius: 100,
                                      child: Icon(
                                        Icons.remove,
                                        size: sy(14),
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        animeUpdate?.controller?.decrementEpisode(currentAnimeId);
                                      },
                                    ),
                                    SizedBox(
                                      height: sy(24),
                                      width: sy(30),
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: episodesTextController,
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
                                          controller.editEpisodes(episodes);
                                        },
                                      ),
                                    ),
                                    SizedButton(
                                      height: sy(24),
                                      width: sy(24),
                                      radius: 100,
                                      child: Icon(
                                        Icons.add,
                                        size: sy(14),
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        animeUpdate?.controller?.incrementEpisode(currentAnimeId);
                                      },
                                    ),
                                    Text(
                                      ' / ${anime?.realEpisodeCount ?? ''}',
                                      style: TextStyle(
                                        color: AppTheme.of(context).text3,
                                        fontSize: sy(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Divider(height: 1, color: AppTheme.of(context).text7),
                              Card(
                                margin: EdgeInsets.symmetric(vertical: sy(2)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: sy(4)),
                                  child: Column(
                                    children: [
                                      AnimeEditDateSelection(
                                        label: 'Start Date',
                                        value: currentInput?.startDate,
                                        dense: true,
                                        verticalPadding: sy(4),
                                        showTodaySetter: true,
                                        showClear: true,
                                        enabled: canEditStartDate ? true : false,
                                        onChanged: (newStartDate) {
                                          controller.editStartDate(newStartDate);
                                        },
                                      ),
                                      AnimeEditDateSelection(
                                        label: 'Finish Date',
                                        value: currentInput?.finishDate,
                                        dense: true,
                                        verticalPadding: sy(4),
                                        showTodaySetter: true,
                                        showClear: true,
                                        enabled: canEditFinishDate ? true : false,
                                        onChanged: (newFinishDate) {
                                          controller.editFinishDate(newFinishDate);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Divider(height: 1, color: AppTheme.of(context).text7),
                              EditFieldInfoRow(
                                label: 'Re-watched',
                                expand: false,
                                child: Row(
                                  children: [
                                    SizedButton(
                                      height: sy(24),
                                      width: sy(24),
                                      radius: 100,
                                      child: Icon(
                                        Icons.remove,
                                        size: sy(14),
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        animeUpdate?.controller?.decrementRewatch(currentAnimeId);
                                      },
                                    ),
                                    SizedBox(
                                      height: sy(24),
                                      width: sy(20),
                                      child: TextFormField(
                                        maxLines: 1,
                                        controller: rewatchTextController,
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
                                          controller.editRewatch(value);
                                        },
                                      ),
                                    ),
                                    SizedButton(
                                      height: sy(24),
                                      width: sy(24),
                                      radius: 100,
                                      child: Icon(
                                        Icons.add,
                                        size: sy(14),
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        animeUpdate?.controller?.incrementRewatch(currentAnimeId);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // Divider(height: 1, color: AppTheme.of(context).text7),
                              SizedBox(height: sy(8)),
                              SizedButton(
                                height: sy(36),
                                width: width,
                                color: AppTheme.of(context).accent,
                                radius: 5,
                                child: Text(
                                  notInMyList ? 'ADD TO LIST' : 'SAVE',
                                  style: TextStyle(
                                    color: AppTheme.of(context).text1,
                                    fontSize: sy(11),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {
                                  controller.saveEdit();
                                },
                              ),
                            ],
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
