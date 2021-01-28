import 'package:momentum/momentum.dart';

import '../../data/index.dart';
import '../../data/types/index.dart';
import '../../mixins/index.dart';
import '../../utils/index.dart';
import 'index.dart';

class AnimeSearchController extends MomentumController<AnimeSearchModel> with AuthMixin, CoreMixin {
  @override
  AnimeSearchModel init() {
    return AnimeSearchModel(
      this,
      query: '',
      results: [],
      prevPage: '',
      nextPage: '',
      loadingResult: false,
      currentPage: 1,
      listResults: [],
    );
  }

  bool isEmpty() {
    return model.results?.isEmpty ?? true;
  }

  void search(String query) {
    model.update(query: query ?? '');
    if (model.query.isEmpty) {
      model.update(listResults: []);
      return;
    }

    List<AnimeDetails> listSource = mal.loadingAnimeList ? [] : animeCache.user_list ?? [];
    var listResults = listSource.where((x) => x.searchMatch(query)).toList();
    model.update(listResults: listResults);
  }

  void sortAnimeSearch() {
    var listResults = List<AnimeDetails>.from(model.listResults ?? []);
    var results = List<AnimeDetails>.from(model.results ?? []);
    switch (listSort.animeSearchSortBy) {
      case AnimeListSortBy.title:
        listResults.sort(compareTitle);
        results.sort(compareTitle);
        break;
      case AnimeListSortBy.globalScore:
        listResults.sort(compareMean);
        results.sort(compareMean);
        break;
      case AnimeListSortBy.member:
        listResults.sort(compareMember);
        results.sort(compareMember);
        break;
      case AnimeListSortBy.userVotes:
        listResults.sort(compareScoringMember);
        results.sort(compareScoringMember);
        break;
      case AnimeListSortBy.lastUpdated:
        listResults.sort(compareLastUpdated);
        results.sort(compareLastUpdated);
        break;
      case AnimeListSortBy.episodesWatched:
        listResults.sort(compareEpisodesWatched);
        results.sort(compareEpisodesWatched);
        break;
      case AnimeListSortBy.startWatchDate:
        listResults.sort(compareStartWatch);
        results.sort(compareStartWatch);
        break;
      case AnimeListSortBy.finishWatchDate:
        listResults.sort(compareFinishWatch);
        results.sort(compareFinishWatch);
        break;
      case AnimeListSortBy.personalScore:
        listResults.sort(comparePersonalScore);
        results.sort(comparePersonalScore);
        break;
      case AnimeListSortBy.totalDuration:
        listResults.sort(compareTotalDuration);
        results.sort(compareTotalDuration);
        break;
      case AnimeListSortBy.startAirDate:
        listResults.sort(compareStartAir);
        results.sort(compareStartAir);
        break;
      case AnimeListSortBy.endAirDate:
        listResults.sort(compareEndAir);
        results.sort(compareEndAir);
        break;
    }
    model.update(listResults: listResults, results: results);
  }

  Future<void> submitMALSearch() async {
    if (model.query.isEmpty) {
      model.update(
        listResults: [],
        results: [],
        prevPage: '',
        nextPage: '',
        loadingResult: false,
      );
      return;
    }

    model.update(loadingResult: true);
    var result = await api.animeSearch(
      accessToken: accessToken,
      query: model.query,
      fields: allAnimeListParams(type: 'my_list_status', omit: omitList1),
    );

    var results = result?.list ?? [];
    var filtered = results.where((x) => !mal.controller.inMyList(x?.id))?.toList();
    model.update(
      results: filtered ?? [],
      prevPage: result?.paging?.prev ?? '',
      nextPage: result?.paging?.next ?? '',
      loadingResult: false,
    );
  }

  void gotoNextPageMALSearch() {
    gotoPageMALSearch(nextPage: model.nextPage);
  }

  void gotoPrevPageMALSearch() {
    gotoPageMALSearch(prevPage: model.prevPage);
  }

  Future<void> gotoPageMALSearch({String prevPage, String nextPage}) async {
    model.update(loadingResult: true);
    var result = await api.animeSearch(
      accessToken: accessToken,
      nextPage: nextPage,
      prevPage: prevPage,
    );
    var results = result?.list ?? [];
    var filtered = results.where((x) => !mal.controller.inMyList(x?.id))?.toList();

    var params = Uri.parse(nextPage ?? prevPage).queryParameters;
    var offset = int.parse(params['offset']);
    var currentPage = (offset ~/ ANIME_SEARCH_LIMIT) + 1;

    model.update(
      results: filtered ?? [],
      prevPage: result?.paging?.prev ?? '',
      nextPage: result?.paging?.next ?? '',
      loadingResult: false,
      currentPage: currentPage,
    );
  }

  int compareTitle(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return a.title.compareTo(b.title);
        break;
      case OrderBy.descending:
        return b.title.compareTo(a.title);
        break;
    }
    return 0;
  }

  int comparePersonalScore(AnimeDetails a, AnimeDetails b) {
    var a_Score = a.myListStatus?.score ?? 0;
    var b_Score = b.myListStatus?.score ?? 0;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return a_Score.compareTo(b_Score);
        break;
      case OrderBy.descending:
        return b_Score.compareTo(a_Score);
        break;
    }
    return 0;
  }

  int compareMean(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return a.mean.compareTo(b.mean);
        break;
      case OrderBy.descending:
        return b.mean.compareTo(a.mean);
        break;
    }
    return 0;
  }

  int compareScoringMember(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return (a.numScoringUsers ?? 0).compareTo(b.numScoringUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.numScoringUsers ?? 0).compareTo(a.numScoringUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareLastUpdated(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        if (a.myListStatus == null) {
          return -1;
        }
        return a.myListStatus?.updatedAt?.compareTo(b.myListStatus?.updatedAt);
        break;
      case OrderBy.descending:
        if (b.myListStatus == null) {
          return 1;
        }
        return b.myListStatus?.updatedAt?.compareTo(a.myListStatus?.updatedAt);
        break;
    }
    return 0;
  }

  int compareMember(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return (a.numListUsers ?? 0).compareTo(b.numListUsers ?? 0);
        break;
      case OrderBy.descending:
        return (b.numListUsers ?? 0).compareTo(a.numListUsers ?? 0);
        break;
    }
    return 0;
  }

  int compareTotalDuration(AnimeDetails a, AnimeDetails b) {
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return a.totalDuration.compareTo(b.totalDuration);
        break;
      case OrderBy.descending:
        return b.totalDuration.compareTo(a.totalDuration);
        break;
    }
    return 0;
  }

  int compareEpisodesWatched(AnimeDetails a, AnimeDetails b) {
    var a_Eps = a.myListStatus?.numEpisodesWatched ?? 0;
    var b_Eps = b.myListStatus?.numEpisodesWatched ?? 0;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        return a_Eps.compareTo(b_Eps);
        break;
      case OrderBy.descending:
        return b_Eps.compareTo(a_Eps);
        break;
    }
    return 0;
  }

  int compareStartWatch(AnimeDetails a, AnimeDetails b) {
    var a_Start = a.myListStatus?.startDate;
    var b_Start = b.myListStatus?.startDate;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        if (a_Start == null) {
          return -1;
        }
        if (b_Start == null) {
          return 1;
        }
        return a_Start.compareTo(b_Start);
        break;
      case OrderBy.descending:
        if (a_Start == null) {
          return 1;
        }
        if (b_Start == null) {
          return -1;
        }
        return b_Start.compareTo(a_Start);
        break;
    }
    return 0;
  }

  int compareFinishWatch(AnimeDetails a, AnimeDetails b) {
    var a_Finish = a.myListStatus?.finishDate;
    var b_Finish = b.myListStatus?.finishDate;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        if (a_Finish == null) {
          return -1;
        }
        if (b_Finish == null) {
          return 1;
        }
        return a_Finish.compareTo(b_Finish);
        break;
      case OrderBy.descending:
        if (a_Finish == null) {
          return 1;
        }
        if (b_Finish == null) {
          return -1;
        }
        return b_Finish.compareTo(a_Finish);
        break;
    }
    return 0;
  }

  int compareStartAir(AnimeDetails a, AnimeDetails b) {
    var a_Start = a.startDate;
    var b_Start = b.startDate;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        if (a_Start == null) {
          return -1;
        }
        if (b_Start == null) {
          return 1;
        }
        return a_Start.compareTo(b_Start);
        break;
      case OrderBy.descending:
        if (a_Start == null) {
          return 1;
        }
        if (b_Start == null) {
          return -1;
        }
        return b_Start.compareTo(a_Start);
        break;
    }
    return 0;
  }

  int compareEndAir(AnimeDetails a, AnimeDetails b) {
    var a_End = a.endDate;
    var b_End = b.endDate;
    switch (listSort.animeSearchOrderBy) {
      case OrderBy.ascending:
        if (a_End == null) {
          return -1;
        }
        if (b_End == null) {
          return 1;
        }
        return a_End.compareTo(b_End);
        break;
      case OrderBy.descending:
        if (a_End == null) {
          return 1;
        }
        if (b_End == null) {
          return -1;
        }
        return b_End.compareTo(a_End);
        break;
    }
    return 0;
  }
}
