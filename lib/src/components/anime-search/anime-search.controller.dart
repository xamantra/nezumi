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
    sortAnimeSearch(listSource: listResults);
  }

  void sortAnimeSearch({
    List<AnimeDetails> listSource,
    List<AnimeDetails> malSource,
  }) {
    var listResults = listSource ?? List<AnimeDetails>.from(model.listResults ?? []);
    var results = malSource ?? List<AnimeDetails>.from(model.results ?? []);
    switch (listSort.animeSearchSortBy) {
      case AnimeListSortBy.title:
        listResults.sort(sorter(compareTitle));
        break;
      case AnimeListSortBy.globalScore:
        listResults.sort(sorter(compareMean));
        break;
      case AnimeListSortBy.member:
        listResults.sort(sorter(compareMember));
        break;
      case AnimeListSortBy.userVotes:
        listResults.sort(sorter(compareScoringMember));
        break;
      case AnimeListSortBy.lastUpdated:
        listResults.sort(sorter(compareLastUpdated));
        break;
      case AnimeListSortBy.episodesWatched:
        listResults.sort(sorter(compareEpisodesWatched));
        break;
      case AnimeListSortBy.startWatchDate:
        listResults.sort(sorter(compareStartWatch));
        break;
      case AnimeListSortBy.finishWatchDate:
        listResults.sort(sorter(compareFinishWatch));
        break;
      case AnimeListSortBy.personalScore:
        listResults.sort(sorter(comparePersonalScore));
        break;
      case AnimeListSortBy.totalDuration:
        listResults.sort(sorter(compareTotalDuration));
        break;
      case AnimeListSortBy.startAirDate:
        listResults.sort(sorter(compareStartAir));
        break;
      case AnimeListSortBy.endAirDate:
        listResults.sort(sorter(compareEndAir));
        break;
    }
    model.update(listResults: listResults, results: results);
  }

  int Function(AnimeDetails, AnimeDetails) sorter(int Function(OrderBy, AnimeDetails, AnimeDetails) sorter) {
    return (a, b) {
      return sorter(listSort.animeSearchOrderBy, a, b);
    };
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
      prevPage: result?.paging?.prev ?? '',
      nextPage: result?.paging?.next ?? '',
      loadingResult: false,
    );
    sortAnimeSearch(malSource: filtered);
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
}
