
import 'package:get/get.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_home.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_token.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_watchList.dart';

class GetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetToken(),fenix: true);
    Get.lazyPut(() => GetHome(),fenix: true);
    Get.lazyPut(() => GetWatchList(),fenix: true);
  }
}
