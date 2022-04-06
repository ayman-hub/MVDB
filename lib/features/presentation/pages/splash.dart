import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_task/features/domain/model/login/get_login_model.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_token.dart';
import 'package:tmdb_task/features/presentation/pages/home/home.dart';
import 'package:tmdb_task/features/presentation/pages/login/login_page.dart';
import 'package:tmdb_task/features/presentation/res/context.dart';
import 'package:tmdb_task/features/presentation/res/injection.dart';
class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool goLogin = true;
  late AnimationController _controller;


  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      if (_controller.isCompleted) {
        LoginModel loginModel = sl<Cases>().getLoginData();
        if(loginModel.success!){
          Get.off(()=>HomePage(),transition: Transition.fadeIn);
        }else{
          Get.off(() => LoginPage(), transition: Transition.fadeIn);
        }
      }
    });
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _context = Context(context);
    return Scaffold(
      backgroundColor: _context.getTheme().backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Lottie.asset("images/splash.json", controller: _controller,
            onLoaded: (LottieComposition composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            }),
      ),
    );
  }
}