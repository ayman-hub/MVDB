import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_watchList.dart';
import 'package:tmdb_task/features/presentation/pages/home/widget/card_widget.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';

class WatchList extends StatefulWidget {
  WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() {
    return _WatchListState();
  }
}

class _WatchListState extends State<WatchList> {

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  bool getLoad = false;
  final watchController = Get.find<GetWatchList>();


  Future<bool> getRefreshData({bool isRefresh = false}) async {
    if (isRefresh) {
    } else {
      if (getLoad) {
        refreshController.loadNoData();
        return false;
      }
    }
LoginModel login = sl<Cases>().getLoginData();
    final response = await sl<Cases>().getWatchList(accountID:login.accountID.toString(),sessionID:login.sessionID.toString(),
       page: isRefresh ? 1 : watchController.watchListModel.page!.toInt() + 1);

    if (response is NowPlayingModel) {
      if (isRefresh) {
        watchController.updateWatchList(response);
      } else {
        if(response.results!.isEmpty){
          getLoad = true;
          refreshController.loadNoData();
          return false;
        }else {
          watchController.updateWatchList(response);
        }
      }
      refreshController.loadComplete();
      return true;
    } else {
      refreshController.loadFailed();
      print('response:: $response');
      return false;
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text('Watch List'),
),
      body: GetBuilder<GetWatchList>(
        init: GetWatchList(),
        builder: (context) {
          return watchController.obx((state){
            NowPlayingModel model = state;
            return SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              onRefresh: () async {
                final result = await getRefreshData(isRefresh: true);
                if (result) {
                  refreshController.refreshCompleted();
                } else {
                  refreshController.refreshFailed();
                }
              },
              onLoading: () async {
                await getRefreshData();
              },
              child: ListView.separated(
                itemCount: model.results?.length??0, itemBuilder: (BuildContext context, int index) {
                  Results data = model.results![index];
                  return CardWidget(data: data,addToWatchList: false,);
              }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10,);
              },
              ),
            );
          },
          onError: (error){
            return Center(child: Text(error.toString(),style: TextStyle(color: Colors.white,fontSize: 20),));
          },onLoading: Center(child: ProgressPage(),)
          ) ;
        }
      ),
    );
  }
}