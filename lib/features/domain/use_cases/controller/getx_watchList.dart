import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:get/get.dart';

class GetWatchList extends GetxController with StateMixin<dynamic> {
  NowPlayingModel watchListModel = NowPlayingModel(results: []);

  @override
  void onInit() {
    getNowPlaying();
  }

  removeFromWatchListModel(Results data){
    watchListModel.results!.removeWhere((element) => element.id == data.id);
    change(watchListModel, status: RxStatus.success());
  }

  updateWatchList(NowPlayingModel data){
    if(data.page! >1 ){
      watchListModel.results!.addAll(data.results!);
      watchListModel.page = data.page;
    }else{
      watchListModel = data;
    }
    change(watchListModel, status: RxStatus.success());
  }

  void getNowPlaying() async {
    LoginModel login = sl<Cases>().getLoginData();
    var response = await sl<Cases>().getWatchList(
        accountID: login.accountID.toString(),
        sessionID: login.sessionID.toString());
    if (response is NowPlayingModel) {
      watchListModel = response;
      change(watchListModel, status: RxStatus.success());
    } else if (response is String) {
      change(response, status: RxStatus.error(response));
    }
  }
}
