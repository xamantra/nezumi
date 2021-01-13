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
    var status = details.myListStatus;
    var inMyList = true;
    if (details != null && status == null) {
      // not in my list
      inMyList = false;
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
    }
    model.update(
      animeDetails: details,
      currentInput: status,
      loading: false,
    );

    sendEvent(AnimeUpdateRewatchEvent(status.numTimesRewatched));
    sendEvent(AnimeUpdateEpisodesEvent(status.numEpisodesWatched));
    if (inMyList) {
      var currentList = List<AnimeData>.from(mal.userAnimeList?.animeList ?? []);
      var anime = currentList.firstWhere((x) => x.node.id == id, orElse: () => null);
      if (anime == null) {
        // newly added entry
        anime = AnimeData.copyFromDetails(details);
      }
      var updated = anime.copyWith(listStatus: status);
      var index = currentList.indexWhere((x) => x.node.id == anime.node.id);
      if (index < 0) {
        currentList.add(updated);
      } else {
        currentList[index] = updated;
      }
      var newList = mal.userAnimeList.copyWith(data: currentList);
      mal.update(userAnimeList: newList);
      mal.controller.sortAnimeList();
    }
  }

  void editInput(AnimeListStatus newValue) {
    model.update(currentInput: newValue);
  }

  void editStatus(String newStatus) {
    var isCompleted = newStatus == 'completed';
    var isRewatching = model.currentInput.isRewatching;
    var updated = model.currentInput.copyWith(status: newStatus);
    if (isRewatching && !isCompleted) {
      updated = updated.copyWith(isRewatching: false);
    }
    editInput(updated);
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
      var currentList = List<AnimeData>.from(mal.userAnimeList?.animeList ?? []);
      var selectedAnime = currentList.firstWhere((x) => x.node.id == animeId, orElse: () => null);
      if (selectedAnime == null) {
        // newly added entry
        selectedAnime = AnimeData.copyFromDetails(model.animeDetails);
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
      var updated = selectedAnime.copyWith(listStatus: animeListStatus);
      var index = currentList.indexWhere((x) => x.node.id == animeId);
      if (index < 0) {
        currentList.add(updated);
      } else {
        currentList[index] = updated;
      }
      var newList = mal.userAnimeList.copyWith(data: currentList);
      mal.update(userAnimeList: newList);
      model.update(currentInput: animeListStatus);
    }
    model.update(loading: false);
    mal.controller.sortAnimeList();
  }

  void incrementEpisode(int animeId) async {
    var anime = (mal.userAnimeList?.animeList ?? []).firstWhere((x) => x.node.id == animeId, orElse: () => null);
    var episode = (anime?.listStatus?.numEpisodesWatched ?? 0) + 1;
    await updateAnimeStatus(animeId: animeId, num_watched_episodes: episode);
    sendEvent(AnimeUpdateEpisodesEvent(episode));
  }

  void decrementEpisode(int animeId) async {
    var anime = (mal.userAnimeList?.animeList ?? []).firstWhere((x) => x.node.id == animeId, orElse: () => null);
    var episode = (anime?.listStatus?.numEpisodesWatched ?? 0) - 1;
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
    var listStatus = model.animeDetails.myListStatus;
    var input = model.currentInput;

    var adding = !mal.inMyList(model.id);

    var currentStatus = listStatus.status;
    var newStatus = input.status;
    var isRewatching = listStatus.isRewatching;
    var newIsRewatching = input.isRewatching;
    var currentEpisodes = listStatus.numEpisodesWatched;
    var newEpisodes = input.numEpisodesWatched;
    var currentStartDate = listStatus.startDate;
    var newStartDate = input.startDate;
    var currentFinishDate = listStatus.finishDate;
    var newFinishDate = input.finishDate;
    var currentNumTimesRewatched = listStatus.numTimesRewatched;
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
