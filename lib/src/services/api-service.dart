import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' show parse;
import 'package:momentum/momentum.dart';

import '../data/index.dart';
import '../utils/index.dart';

class ApiService extends MomentumService {
  final dio = Dio(
    BaseOptions(),
  )..interceptors.add(
      HttpInterceptor(),
    );

  Future<MyAnimeListToken> getToken({
    @required String code,
    @required String codeVerifier,
  }) async {
    try {
      var path = 'https://myanimelist.net/v1/oauth2/token';
      var data = FormData.fromMap({
        'client_id': client_id,
        'grant_type': 'authorization_code',
        'code': code,
        'code_verifier': codeVerifier,
        'redirect_uri': redirect_uri,
      });
      var response = await dio.post(path, data: data);
      var result = MyAnimeListToken.fromJson(response.data);
      return result;
    } catch (e) {
      print(['ApiService.getToken', e]);
      return null;
    }
  }

  Future<T> httpGet<T>(
    String url, {
    int timeout = 10000,
    @required String accessToken,
    @required T Function(Map<String, dynamic>) transformer,
  }) async {
    try {
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          receiveTimeout: timeout ?? 10000,
          sendTimeout: timeout ?? 10000,
        ),
      );
      var result = transformer(response.data);
      return result;
    } catch (e) {
      print(['ApiService.httpGet', e]);
      return null;
    }
  }

  Future<MyAnimeListProfile> getProfile({@required String accessToken}) async {
    try {
      var path = 'https://api.myanimelist.net/v2/users/@me';
      var data = {
        'fields': 'anime_statistics',
      };
      var response = await dio.get(
        path,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          receiveTimeout: 10000,
          sendTimeout: 10000,
        ),
      );
      var result = MyAnimeListProfile.fromJson(response.data);
      return result;
    } catch (e) {
      print(['ApiService.getProfile', e]);
      return null;
    }
  }

  Future<UserAnimeList> getUserAnimeList({
    @required String accessToken,
    String nextPage,
    String status,
    UserAnimeList current,
    List<String> statusParams = const [],
    List<String> animeParams = const [],
    String customFields,
    int timeout = 10000,
  }) async {
    try {
      var path = 'https://api.myanimelist.net/v2/users/@me/animelist';
      var fields = '';
      if (statusParams.isNotEmpty) {
        fields = 'list_status{${statusParams.join(",")}}';
      }
      if (animeParams.isNotEmpty) {
        if (statusParams.isNotEmpty) {
          fields += ',';
        }
        fields += '${animeParams.join(",")}';
      }
      var data = {
        'fields': customFields ?? fields,
        'limit': 1000,
        'nsfw': true,
      };
      if (status != null) {
        data.putIfAbsent('status', () => status);
      }
      Response<dynamic> response;
      if (nextPage != null && current != null) {
        var result = await httpGet(
          nextPage,
          timeout: timeout,
          accessToken: accessToken,
          transformer: UserAnimeList.fromJson,
        );
        var merged = List<AnimeDetails>.from(current.list);
        merged.addAll(result.list);
        var n = UserAnimeList(
          list: merged,
          paging: result?.paging,
        );
        return getUserAnimeList(
          accessToken: accessToken,
          nextPage: n.paging?.next,
          current: n,
          statusParams: statusParams,
          animeParams: animeParams,
          timeout: timeout,
        );
      } else {
        if (current == null) {
          response = await dio.get(
            path,
            queryParameters: data,
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
              receiveTimeout: timeout,
              sendTimeout: timeout,
            ),
          );
        }
        var result = response == null ? null : UserAnimeList.fromJson(response.data);
        if (result?.paging?.next != null) {
          return getUserAnimeList(
            accessToken: accessToken,
            nextPage: result.paging?.next,
            current: result,
            statusParams: statusParams,
            animeParams: animeParams,
            timeout: timeout,
          );
        }
        return current ?? result;
      }
    } catch (e) {
      print(['ApiService.getUserAnimeList', e]);
      return null;
    }
  }

  Future<UserAnimeHistory> getAnimeHistory({@required String username}) async {
    List<AnimeHistory> data = [];
    try {
      var path = 'https://myanimelist.net/history/$username/anime';
      var response = await dio.get(
        path,
        options: Options(
          responseType: ResponseType.plain,
          receiveTimeout: 10000,
          sendTimeout: 10000,
        ),
      );
      var doc = parse(response.data);
      var elements = doc.querySelectorAll('div.history_content_wrapper > table > tbody > tr');
      for (var element in elements) {
        try {
          var header = element.querySelector('.normal_header');
          if (header == null) {
            var result = parseAnimeHistory(element);
            if (result != null) {
              data.add(result);
            }
          }
        } catch (e, trace) {
          print([e, trace]);
        }
      }
      return UserAnimeHistory(list: data);
    } catch (e) {
      print(['ApiService.getAnimeHistory', e]);
      return null;
    }
  }

  Future<AnimeUpdateResponse> updateAnimeStatus({
    @required String accessToken,
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
    try {
      var path = 'https://api.myanimelist.net/v2/anime/$animeId/my_list_status';
      Map<String, dynamic> data = {};

      /* process parameters */
      if (status != null) data.putIfAbsent('status', () => status);
      if (is_rewatching != null) data.putIfAbsent('is_rewatching', () => is_rewatching);
      if (score != null) data.putIfAbsent('score', () => score);
      if (num_watched_episodes != null) data.putIfAbsent('num_watched_episodes', () => num_watched_episodes);
      if (priority != null) data.putIfAbsent('priority', () => priority);
      if (num_times_rewatched != null) data.putIfAbsent('num_times_rewatched', () => num_times_rewatched);
      if (tags != null) data.putIfAbsent('tags', () => tags);
      if (comments != null) data.putIfAbsent('comments', () => comments);
      if (start_date != null) data.putIfAbsent('start_date', () => start_date);
      if (finish_date != null) data.putIfAbsent('finish_date', () => finish_date);
      /* process parameters */

      var response = await dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          receiveTimeout: 10000,
          sendTimeout: 10000,
          contentType: 'application/x-www-form-urlencoded',
        ),
      );
      var result = AnimeUpdateResponse.fromJson(response.data);
      return result;
    } catch (e) {
      print(['ApiService.updateAnimeStatus', e]);
      return null;
    }
  }

  Future<AnimeList> animeSearch({
    @required String accessToken,
    String query,
    String prevPage,
    String nextPage,
    String fields,
    int timeout = 10000,
  }) async {
    try {
      var path = 'https://api.myanimelist.net/v2/anime';
      var data = {
        'q': query,
        'fields': fields,
        'limit': ANIME_SEARCH_LIMIT,
        'offset': 0,
        'nsfw': true,
      };
      if (nextPage != null) {
        var result = await httpGet(
          nextPage,
          timeout: timeout,
          accessToken: accessToken,
          transformer: AnimeList.fromJson,
        );
        return result;
      } else if (prevPage != null) {
        var result = await httpGet(
          prevPage,
          timeout: timeout,
          accessToken: accessToken,
          transformer: AnimeList.fromJson,
        );
        return result;
      } else {
        var response = await dio.get(
          path,
          queryParameters: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
            receiveTimeout: timeout,
            sendTimeout: timeout,
          ),
        );
        return AnimeList.fromJson(response.data);
      }
    } catch (e) {
      print(['ApiService.animeSearch', e]);
      return null;
    }
  }

  Future<AnimeList> animeTop({
    @required String accessToken,
    String type = 'all',
    String prevPage,
    String nextPage,
    String fields,
    int offset = 0,
    int timeout = 10000,
  }) async {
    try {
      var path = 'https://api.myanimelist.net/v2/anime/ranking';
      var data = {
        'ranking_type': type ?? 'all',
        'fields': fields,
        'limit': ANIME_TOP_LIMIT,
        'offset': offset ?? 0,
        'nsfw': true,
      };
      if (nextPage != null) {
        var result = await httpGet(
          nextPage,
          timeout: timeout,
          accessToken: accessToken,
          transformer: AnimeList.fromJson,
        );
        return result;
      } else if (prevPage != null) {
        var result = await httpGet(
          prevPage,
          timeout: timeout,
          accessToken: accessToken,
          transformer: AnimeList.fromJson,
        );
        return result;
      } else {
        var response = await dio.get(
          path,
          queryParameters: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
            receiveTimeout: timeout,
            sendTimeout: timeout,
          ),
        );
        return AnimeList.fromJson(response.data);
      }
    } catch (e) {
      print(['ApiService.animeTop', e]);
      return null;
    }
  }

  Future<AnimeList> animeSeason({
    @required String accessToken,
    @required int year,
    @required String season,
    String fields,
    int timeout = 10000,
  }) async {
    try {
      var path = 'https://api.myanimelist.net/v2/anime/season/$year/$season';
      var data = {
        'fields': fields,
        'limit': ANIME_SEASON_LIMIT, // every season usually have 150 to 300 entries.
        'offset': 0,
        'nsfw': true,
      };

      var response = await dio.get(
        path,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ),
      );
      return AnimeList.fromJson(response.data);
    } catch (e) {
      print(['ApiService.animeSeason', e]);
      return null;
    }
  }

  Future<AnimeDetails> getAnimeDetails(
    int id, {
    @required String accessToken,
    @required String fields,
    int timeout = 10000,
  }) async {
    try {
      var path = 'https://api.myanimelist.net/v2/anime/$id';
      var data = {
        'fields': fields,
      };
      var response = await dio.get(
        path,
        queryParameters: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          receiveTimeout: timeout,
          sendTimeout: timeout,
        ),
      );
      return AnimeDetails.fromJson(response.data);
    } catch (e) {
      print(['ApiService.getAnimeDetails', e]);
      return null;
    }
  }
}
