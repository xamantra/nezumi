import 'package:flutter/foundation.dart';
import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeUpdateController extends MomentumController<AnimeUpdateModel> with CoreMixin, AuthMixin {
  @override
  AnimeUpdateModel init() {
    return AnimeUpdateModel(
      this,
      loading: false,
    );
  }

  void setCurrentAnime({
    String title,
    int id,
  }) async {
    model.update(id: id, title: title, loading: true);
    var details = await api.getAnimeDetails(
      id,
      accessToken: accessToken,
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );
    if (details == null) {
      await Future.delayed(Duration(milliseconds: 2000));
      sendEvent(AnimeFailedToloadError('Failed to load anime details.'));
      model.update(loading: false);
      return;
    }
    var status = details?.myListStatus;
    if (status == null) {
      // not in my list
      status = AnimeListStatus(
        status: 'plan_to_watch',
        score: 0,
        numEpisodesWatched: 0,
        isRewatching: false,
        comments: '',
        priority: 0,
        tags: [],
        rewatchValue: 0,
        numTimesRewatched: 0,
      );
      details = details.copyWith(myListStatus: status);
    } else {
      await animeCache.cacheAnime(details);
    }

    sendEvent(AnimeUpdateRewatchEvent(status.numTimesRewatched));
    sendEvent(AnimeUpdateEpisodesEvent(status.numEpisodesWatched));

    model.update(
      animeDetails: details,
      currentInput: status,
      loading: false,
    );
    mal.controller.sortAnimeList();
  }

  void editInput(AnimeListStatus newValue) {
    model.update(currentInput: newValue);
  }

  void editStatus(String newStatus) {
    var anime = model.animeDetails;
    var animeStatus = anime.status;
    if (newStatus == 'completed' && animeStatus == 'currently_airing') {
      sendEvent(AnimeUpdateError('Cannot set as completed a currently airing show.'));
      return;
    }

    var isCompleted = newStatus == 'completed';
    var isRewatching = model.currentInput.isRewatching;
    var updated = model.currentInput.copyWith(status: newStatus);
    if (isRewatching && !isCompleted) {
      updated = updated.copyWith(isRewatching: false);
    }
    editInput(updated);

    var episodes = anime.numEpisodes ?? 0;
    if (episodes != 0) {
      sendEvent(AnimeUpdateEpisodesEvent(episodes));
      editEpisodes(episodes);
    }
  }

  void editIsRewatching(bool isRewatching) {
    var updated = model.currentInput.copyWith(isRewatching: isRewatching);
    editInput(updated);
  }

  void editEpisodes(int newEpisodeCoumt) {
    var updated = model.currentInput.copyWith(numEpisodesWatched: newEpisodeCoumt);
    editInput(updated);
  }

  void editStartDate(String newStartDate) {
    var updated = model.currentInput.copyWith(startDate: newStartDate);
    editInput(updated);
  }

  void editFinishDate(String newFinishDate) {
    var updated = model.currentInput.copyWith(finishDate: newFinishDate);
    editInput(updated);
  }

  void editRewatch(String value) {
    var numTimesRewatched = trycatch(() => int.parse(value), 0);
    var updated = model.currentInput.copyWith(numTimesRewatched: numTimesRewatched);
    editInput(updated);
  }

  Future<void> updateAnimeStatus({
    @required int animeId,
    String status,
    bool is_rewatching,
    int score,
    int num_watched_episodes,
    int priority,
    int num_times_rewatched,
    int rewatch_value,
    List<String> tags,
    String comments,
    String start_date,
    String finish_date,
  }) async {
    model.update(loading: true);
    var response = await api.updateAnimeStatus(
      accessToken: accessToken,
      animeId: animeId,
      status: status,
      score: score,
      is_rewatching: is_rewatching,
      num_watched_episodes: num_watched_episodes,
      priority: priority,
      num_times_rewatched: num_times_rewatched,
      rewatch_value: rewatch_value,
      tags: tags,
      comments: comments,
      start_date: start_date,
      finish_date: finish_date,
    );
    if (response != null) {
      var selectedAnime = animeCache.user_list.firstWhere((x) => x.id == animeId, orElse: () => null);
      if (selectedAnime == null) {
        // newly added entry
        selectedAnime = model.animeDetails;
      }
      var animeListStatus = AnimeListStatus(
        status: response.status,
        score: response.score,
        numEpisodesWatched: response.numEpisodesWatched,
        isRewatching: response.isRewatching,
        updatedAt: response.updatedAt,
        comments: response.comments,
        tags: response.tags,
        priority: response.priority,
        numTimesRewatched: response.numTimesRewatched,
        rewatchValue: response.rewatchValue,
        startDate: response.startDate,
        finishDate: response.finishDate,
      );
      var updated = selectedAnime.copyWith(myListStatus: animeListStatus);
      await animeCache.cacheAnime(updated);
      model.update(currentInput: animeListStatus);
    }
    model.update(loading: false);
    mal.controller.sortAnimeList();
  }

  void incrementEpisode(int animeId) async {
    var anime = (animeCache.user_list ?? []).firstWhere((x) => x.id == animeId, orElse: () => null);
    var episode = (anime?.myListStatus?.numEpisodesWatched ?? 0) + 1;
    await updateAnimeStatus(animeId: animeId, num_watched_episodes: episode);
    sendEvent(AnimeUpdateEpisodesEvent(episode));
  }

  void decrementEpisode(int animeId) async {
    var anime = (animeCache.user_list ?? []).firstWhere((x) => x.id == animeId, orElse: () => null);
    var episode = (anime?.myListStatus?.numEpisodesWatched ?? 0) - 1;
    if (episode < 0) {
      episode = 0;
    }
    await updateAnimeStatus(animeId: animeId, num_watched_episodes: episode);
    sendEvent(AnimeUpdateEpisodesEvent(episode));
  }

  void incrementRewatch(int animeId) {
    var numTimesRewatched = (model.currentInput?.numTimesRewatched ?? 0) + 1;
    editRewatch(numTimesRewatched.toString());
    sendEvent(AnimeUpdateRewatchEvent(numTimesRewatched));
  }

  void decrementRewatch(int animeId) {
    var numTimesRewatched = (model.currentInput?.numTimesRewatched ?? 0) - 1;
    if (numTimesRewatched < 0) {
      numTimesRewatched = 0;
    }
    editRewatch(numTimesRewatched.toString());
    sendEvent(AnimeUpdateRewatchEvent(numTimesRewatched));
  }

  void saveEdit() async {
    var myListStatus = model.animeDetails.myListStatus;
    var input = model.currentInput;

    var adding = !mal.controller.inMyList(model.id);

    var currentStatus = myListStatus.status;
    var newStatus = input.status;
    var isRewatching = myListStatus.isRewatching;
    var newIsRewatching = input.isRewatching;
    var currentEpisodes = myListStatus.numEpisodesWatched;
    var newEpisodes = input.numEpisodesWatched;
    var currentStartDate = myListStatus.startDate;
    var newStartDate = input.startDate;
    var currentFinishDate = myListStatus.finishDate;
    var newFinishDate = input.finishDate;
    var currentNumTimesRewatched = myListStatus.numTimesRewatched;
    var newNumTimesRewatched = input.numTimesRewatched;

    var animeId = model.animeDetails.id;
    var status = currentStatus == newStatus ? null : newStatus;
    var is_rewatching = isRewatching == newIsRewatching ? null : newIsRewatching;
    var num_watched_episodes = currentEpisodes == newEpisodes ? null : newEpisodes;
    var start_date = currentStartDate == newStartDate ? null : newStartDate;
    var finish_date = currentFinishDate == newFinishDate ? null : newFinishDate;
    var num_times_rewatched = currentNumTimesRewatched == newNumTimesRewatched ? null : newNumTimesRewatched;

    await updateAnimeStatus(
      animeId: animeId,
      status: adding ? newStatus : status,
      is_rewatching: adding ? newIsRewatching : is_rewatching,
      num_watched_episodes: adding ? newEpisodes : num_watched_episodes,
      num_times_rewatched: adding ? newNumTimesRewatched : num_times_rewatched,
      start_date: adding ? newStartDate : start_date,
      finish_date: adding ? newFinishDate : finish_date,
    );
  }
}
