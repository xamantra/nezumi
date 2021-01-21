import 'package:momentum/momentum.dart';

import '../../data/index.dart';
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

  void search(String query) {
    model.update(query: query ?? '');
    if (model.query.isEmpty) {
      model.update(listResults: []);
      return;
    }

    List<AnimeDetails> listSource = mal.loadingAnimeList ? [] : mal.userAnimeList?.list ?? [];
    var listResults = listSource.where((x) => x.searchMatch(query)).toList();
    model.update(listResults: listResults);
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
    var filtered = results.where((x) => !mal.inMyList(x?.id))?.toList();
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
    var filtered = results.where((x) => !mal.inMyList(x?.id))?.toList();

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
