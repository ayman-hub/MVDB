import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/model/movie/details_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_home.dart';
import 'package:tmdb_task/features/presentation/pages/login/login_page.dart';
import 'package:tmdb_task/features/presentation/pages/watch_list/watch_list.dart';
import 'package:tmdb_task/features/presentation/res/context.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';
import 'package:tmdb_task/features/presentation/res/toast_utils.dart';
import 'package:tmdb_task/features/presentation/widgets/image_widget.dart';

class Zoom extends StatefulWidget {
  Zoom({Key? key, required this.body, required this.z,required this.controller}) : super(key: key);
  Widget body;
  final ZoomDrawerController z;
  final AnimationController controller;

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    Context _context = Context(context);
    return ZoomDrawer(
      controller: widget.z,
      borderRadius: 24,
      style: DrawerStyle.Style1,
      openCurve: Curves.fastOutSlowIn,
      disableGesture: false,
      mainScreenTapClose: false,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.white,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: widget.body,
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          body: Container(
            width: _context.getWidth() / 1.5,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: const Text('Movie App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                ),
                const SizedBox(height: 10,),
                sl<Cases>().getLoginData().sessionID != null? Obx((){
                  if(showProgress.value){
                    return ProgressPage();
                  }else{
                    return ListTile(
                      onTap: goToWatchList,
                      leading: const Icon(Icons.list,color: Colors.white,),
                      title: const Text('Watch List',style: TextStyle(color: Colors.white,fontSize: 15),),
                    );
                  }
                }):Container(),
                ListTile(
                  onTap: (){
                    sl<Cases>().setLoginData(LoginModel(success: false));
                    Get.offAll(()=>LoginPage(),transition: Transition.fadeIn);
                  },
                  title: const Text('Log out',style:  TextStyle(color: Colors.white,fontSize: 15),),
                  leading: const Icon(Icons.logout,color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
final showProgress = false.obs;
  void goToWatchList()async{
    LoginModel login = sl<Cases>().getLoginData();
    if(login.accountID != null){
      widget.controller.fling(velocity: 1.0);
      widget.z.close!.call();
      Get.to(() => WatchList(),
          transition: Transition.fadeIn);
    }else{
      showProgress(true);
      var accountResponse = await sl<Cases>().getDetails(login.sessionID.toString());
      showProgress(false);
      if(accountResponse is DetailsModel){
        login.accountID = accountResponse.id.toString();
        sl<Cases>().setLoginData(login);
        goToWatchList();
      }else{
        showToast(accountResponse.toString());
      }
    }
  }
}
