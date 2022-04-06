import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_home.dart';
import 'package:tmdb_task/features/presentation/pages/home/widget/home_body.dart';
import 'package:tmdb_task/features/presentation/pages/home/widget/slider_home_widget.dart';
import 'package:tmdb_task/features/presentation/pages/home/widget/zoom_drawer.dart';
import 'package:tmdb_task/features/presentation/res/context.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: 1.0,
  );
  final homeController = Get.find<GetHome>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool getLoad = false;

  Future<bool> getRefreshData({bool isRefresh = false}) async {
    if (isRefresh) {
    } else {
      if (getLoad) {
        refreshController.loadNoData();
        return false;
      }
    }

    final response = await sl<Cases>().getNowPlaying(
        isRefresh ? 1 : homeController.nowPlayingModel.value.page!.toInt() + 1);

    if (response is NowPlayingModel) {
      if (isRefresh) {
        homeController.updateNowPlayingModel(response,true);
      } else {
        if(response.results!.isEmpty){
          getLoad = true;
          refreshController.loadNoData();
          return false;
        }else {
          homeController.updateNowPlayingModel(response,false);
        }
      }
      refreshController.loadComplete();
      return true;
    } else {
      refreshController.loadFailed();
      //print('response:: $response');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Context _context = Context(context);
    final ZoomDrawerController z = ZoomDrawerController();
    return Zoom(
      z: z,
      controller :controller,
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(
            onPressed: () {
              controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
              if (z.isOpen!.call()) {
                z.close!.call();
              } else {
                z.open!.call();
              }
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: controller.view,
            ),
          ),
        ),
        body: SmartRefresher(
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
          child: ListView(
            children: [
              SliderHome(),
              const SizedBox(
                height: 10,
              ),
              BodyHome()
            ],
          ),
        ),
      ),
    );
  }
}
