import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:get/get.dart';

class GetHome extends GetxController with StateMixin<dynamic> {
  final nowPlayingModel = NowPlayingModel(results: []).obs;

  @override
  void onInit() {
    if(nowPlayingModel.value.results!.isEmpty){
      getNowPlaying();
    }
  }

  updateNowPlayingModel(NowPlayingModel response,bool isRefreshed){
   if(isRefreshed) {
     nowPlayingModel.value = response;
     change(nowPlayingModel.value, status: RxStatus.success());
   }else{
      nowPlayingModel.value.results!.addAll(response.results!);
      nowPlayingModel.value.page = response.page;
     change(nowPlayingModel.value, status: RxStatus.success());
    }
  }

  void getNowPlaying() async {
    var response = await sl<Cases>().getNowPlaying(1);
    if (response is NowPlayingModel) {
      nowPlayingModel(response);
      change(nowPlayingModel.value, status: RxStatus.success());
    } else if (response is String) {
      change(response, status: RxStatus.error(response.toString()));
    }
  }


}
