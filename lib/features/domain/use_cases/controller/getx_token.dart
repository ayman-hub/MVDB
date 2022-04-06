import 'package:get/get.dart';
import 'package:tmdb_task/features/domain/model/login/post_login.dart';
import 'package:tmdb_task/features/domain/model/session_model.dart';
import 'package:tmdb_task/features/domain/model/token_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:tmdb_task/features/presentation/res/toast_utils.dart';

class GetToken extends GetxController {
  TokenModel token  = TokenModel(requestToken: '');
  String sessionID = '';
  final postLogin = RequestLoginModel().obs;



  updateSession(String session){
    sessionID = session;
  }


 Future<dynamic> getToken()async{
      var response = await sl<Cases>().createToken();
      if (response is TokenModel) {
        token = response;
        return token;
      } else if (response is String) {
        print('error:: $response');
        return response;
      }
  }
}
