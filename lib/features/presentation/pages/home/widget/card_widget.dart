import 'package:flutter/material.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/movie/details_model.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/model/movie/post_watch_list.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_watchList.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';
import 'package:tmdb_task/features/presentation/res/toast_utils.dart';
import 'package:tmdb_task/features/presentation/widgets/image_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  CardWidget({Key? key, required this.data ,required this.addToWatchList}) : super(key: key);
  Results data;
  bool addToWatchList;
late PostWatchListModel postWatchListModel;

  @override
  Widget build(BuildContext context) {
    postWatchListModel = PostWatchListModel(mediaType: 'movie',mediaId: data.id.toString(),watchlist: true);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 150,
      child: Row(
        children: [
          Container(
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      width: 180.w,
                      height: 230.h,
                      child: ImageWidget(img: data.posterPath.toString())),
                  Container(
                      width: 180.w,
                      height: 230.h,
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate,
                            color: Colors.yellow,
                          ),
                          Text(
                            data.voteAverage.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )),
                ],
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.title.toString().toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      )),
                  Expanded(
                    child: Text(
                      data.overview.toString(),
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: sl<Cases>().getLoginData().success!
                          ? Obx((){
                            if(showProgress.value){
                              return ProgressPage();
                            }else if(showSuccess.value){
                              return Container(
                                height: 30,
                                width: 150,
                                alignment: Alignment.center,
                                color: Colors.green,
                                child: const Text('Success',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                              );
                            }else{
                             return TextButton.icon(
                                  onPressed: addToWatchListMethod,
                                  icon:  Icon(
                                    addToWatchList?Icons.add:Icons.remove,
                                    color:addToWatchList? Colors.white:Colors.red,
                                  ),
                                  label: Text(addToWatchList?'Add To WatchList':'remove from WatchList'));
                            }
                      })
                          : Container())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
final showProgress = false.obs;
  void addToWatchListMethod() async {
    try{
      showProgress(true);
      LoginModel login = sl<Cases>().getLoginData();
      if (login.accountID == null) {
        var accountResponse = await sl<Cases>().getDetails(login.sessionID.toString());
        if (accountResponse is DetailsModel) {
          login.accountID = accountResponse.id.toString();
          sl<Cases>().setLoginData(login);
          addToWatchListMethod();
        } else {
          throw (accountResponse.toString());
        }
      } else {
        postWatchListModel.accountID = login.accountID;
        postWatchListModel.sessionID = login.sessionID;
        postWatchListModel.watchlist = addToWatchList;
        var addResponse = await sl<Cases>().addToWatchList(postWatchListModel);
        showProgress(false);
        if (addResponse == true) {
          showSuccessMethod();
          if(addToWatchList == false){
            final watchController = Get.find<GetWatchList>();
            watchController.removeFromWatchListModel(data);
          }
        } else {
          throw (addResponse.toString());
        }
      }
    }catch(e){
      showProgress(false);
      showToast(e.toString());
    }
  }
 final showSuccess = false.obs;
  showSuccessMethod(){
    showSuccess(true);
    Future.delayed(Duration(seconds: 1),(){
      showSuccess(false);
    });
  }
}
