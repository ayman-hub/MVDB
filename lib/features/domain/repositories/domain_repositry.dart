


import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';

abstract class DomainRepositry {
// from api
  Future<dynamic> createSession(String token);

  Future<dynamic> createToken();

  Future<dynamic> validateLogin(RequestLoginModel login);

  Future<dynamic> addToWatchList(PostWatchListModel watchListModel);

  Future<dynamic> getWatchList({required String accountID,required String sessionID,int page = 1});

  Future<dynamic> getDetails(String sessionID);

  Future<dynamic> getNowPlaying(int page);


  //sharedPreference

  Future<void> setLoginData(LoginModel loginDataEntities);

  dynamic getLoginData();


}
