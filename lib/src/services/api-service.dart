import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' show parse;
import 'package:momentum/momentum.dart';

import '../data/index.dart';
import '../utils/index.dart';

class ApiService extends MomentumService {
  final dio = Dio();

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
          receiveTimeout: 10000,
          sendTimeout: 10000,
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
      };
      Response<dynamic> response;
      if (nextPage != null && current != null) {
        var result = await httpGet(
          nextPage,
          accessToken: accessToken,
          transformer: UserAnimeList.fromJson,
        );
        var merged = List<AnimeData>.from(current.animeList);
        merged.addAll(result.animeList);
        var n = UserAnimeList(
          animeList: merged,
          paging: result?.paging,
        );
        return getUserAnimeList(
          accessToken: accessToken,
          nextPage: n.paging?.next,
          current: n,
          statusParams: statusParams,
          animeParams: animeParams,
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
          );
        }
        return current;
      }
    } catch (e) {
      print(['ApiService.getUserAnimeList', e]);
      return null;
    }
  }

  Future<UserAnimeHistory> getAnimeHistory({@required String username}) async {
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
      List<AnimeHistory> data = [];
      for (var element in elements) {
        var header = element.querySelector('.normal_header');
        if (header == null) {
          var result = parseAnimeHistory(element);
          if (result != null) {
            data.add(result);
          }
        }
      }
      return UserAnimeHistory(list: data);
    } catch (e) {
      print(['ApiService.getAnimeHistory', e]);
      return null;
    }
  }
}
