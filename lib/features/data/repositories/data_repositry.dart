import 'package:flutter/cupertino.dart';
import 'package:tmdb_task/features/data/data_sources/local_data/shared_preferences.dart';
import 'package:tmdb_task/features/data/remote_data/dio_remote.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';
import 'package:tmdb_task/features/domain/repositories/domain_repositry.dart';

class DataRepositry extends DomainRepositry {
  DioRemote dioRemote;
  GetSharedPreference getSharedPreference;

  DataRepositry({
    required this.dioRemote,
    required this.getSharedPreference,
  });

  @override
  Future addToWatchList(PostWatchListModel watchListModel) {
    return dioRemote.addToWatchList(watchListModel);
  }

  @override
  Future createSession(String token) {
    return dioRemote.createSession(token);
  }

  @override
  Future createToken() {
    return dioRemote.createToken();
  }

  @override
  Future getDetails(String sessionID) {
    return dioRemote.getDetails(sessionID);
  }

  @override
  Future getNowPlaying(int page) {
    return dioRemote.getNowPlaying(page);
  }

  @override
  Future getWatchList({required String accountID,required String sessionID,int page = 1}) {
    return dioRemote.getWatchList(accountID: accountID,sessionID:sessionID,page: page);
  }

  @override
  Future validateLogin(RequestLoginModel login) {
    return dioRemote.validateLogin(login);
  }

  @override
  getLoginData() {
    return getSharedPreference.getLoginData();
  }

  @override
  Future<void> setLoginData(LoginModel loginDataEntities) {
    return getSharedPreference.setLoginData(loginDataEntities);
  }
}
