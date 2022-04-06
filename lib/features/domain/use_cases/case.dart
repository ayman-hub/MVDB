import 'package:flutter/cupertino.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';
import 'package:tmdb_task/features/domain/repositories/domain_repositry.dart';



class Cases {
  DomainRepositry domainRepositry;

  Cases({required this.domainRepositry});


  Future<dynamic> createSession(String token){
    return domainRepositry.createSession(token);
  }

  Future<dynamic> createToken(){
    return domainRepositry.createToken();
  }

  Future<dynamic> validateLogin(RequestLoginModel login){
    return domainRepositry.validateLogin(login);
  }

  Future<dynamic> addToWatchList(PostWatchListModel watchListModel){
    return domainRepositry.addToWatchList(watchListModel);
  }

  Future<dynamic> getWatchList({required String accountID,required String sessionID,int page = 1}){
    return domainRepositry.getWatchList(accountID: accountID,sessionID:sessionID,page:page);
  }

  Future<dynamic> getDetails(String sessionID){
    return domainRepositry.getDetails(sessionID);
  }

  Future<dynamic> getNowPlaying(int page){
    return domainRepositry.getNowPlaying(page);
  }

  Future<void> setLoginData(LoginModel loginDataEntities){
    return domainRepositry.setLoginData(loginDataEntities);
  }

  LoginModel getLoginData(){
    return domainRepositry.getLoginData();
  }

}
