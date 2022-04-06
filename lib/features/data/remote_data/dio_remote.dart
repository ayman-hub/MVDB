import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/movie/details_model.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';
import 'package:tmdb_task/features/domain/model/session_model.dart';
import 'package:tmdb_task/features/domain/model/token_model.dart';

import 'dio_helper.dart';

class DioRemote {
  DioHelper dioHelper;

  DioRemote(this.dioHelper);

  Future<dynamic> createSession(String token) async {
    return dioHelper.post({"request_token": token}, path: '/authentication/session/new',onSuccess: (Map<String, dynamic> data) => SessionModel.fromJson(data));
  }

  Future<dynamic> createToken() async {
    return dioHelper.get({},
        path: '/authentication/token/new',
        onSuccess: (Map<String, dynamic> data) => TokenModel.fromJson(data));
  }

  Future<dynamic> validateLogin(RequestLoginModel login) async {
    return dioHelper.post(login.toJson(),
        path: '/authentication/token/validate_with_login',
        onSuccess: (Map<String, dynamic> data) => LoginModel.fromJson(data));
  }

  Future<dynamic> addToWatchList(PostWatchListModel watchListModel) async {
    return dioHelper.post(watchListModel.toJson(),
        path:
            '/account/:${watchListModel.accountID}/watchlist?session_id=${watchListModel.sessionID}',
        onSuccess: (Map<String, dynamic> data) => true);
  }

  Future<dynamic> getWatchList({required String accountID,required String sessionID,int page = 1}) async {
    return dioHelper.get({},
        path: '/account/:$accountID/watchlist/movies?session_id=$sessionID&page=$page',
        onSuccess: (Map<String, dynamic> data) => NowPlayingModel.fromJson(data));
  }

  Future<dynamic> getDetails(String sessionID) async {
    return dioHelper.get({
      'session_id': sessionID,
    }, path: '/account', onSuccess: (Map<String, dynamic> data) => DetailsModel.fromJson(data));
  }

  Future<dynamic> getNowPlaying(int page) async {
    return dioHelper.get({'page':page}, path: '/movie/now_playing', onSuccess: (Map<String, dynamic> data) => NowPlayingModel.fromJson(data));
  }
}
