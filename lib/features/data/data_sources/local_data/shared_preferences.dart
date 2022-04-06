import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';




const String SHAREDPREFERENCE_USER = "user";


class GetSharedPreference {
  GetStorage sharedPreferences ;

  GetSharedPreference({required this.sharedPreferences});

  Future<void> setLoginData(
      LoginModel loginDataEntities) async {
    sharedPreferences.write(SHAREDPREFERENCE_USER,loginDataEntities.toJson());
  }

  LoginModel getLoginData() {
    if(sharedPreferences.read(SHAREDPREFERENCE_USER)!= null){
      return LoginModel.fromJson(
          sharedPreferences.read(SHAREDPREFERENCE_USER));}else{
      return LoginModel(success: false);
    }
  }
}
