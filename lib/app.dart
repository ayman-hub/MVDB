import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_task/features/presentation/pages/home/home.dart';
import 'package:tmdb_task/features/presentation/pages/login/login_page.dart';
import 'package:tmdb_task/features/presentation/pages/splash.dart';
import 'package:tmdb_task/features/presentation/res/generate_material_color.dart';
import 'package:tmdb_task/main.dart';

import 'features/domain/use_cases/controller/get_binding.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => GetMaterialApp(
              title: 'MVDB',
              builder: (context,child){
                ScreenUtil.setContext(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: child!,
                );
              },
              theme: ThemeData(
                primaryColor: const Color(0xFF1B2C3B),
                backgroundColor: const Color(0xff1C262F),
                scaffoldBackgroundColor: const Color(0xff1C262F),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF1B2C3B),
                  centerTitle: true,
                  titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)
                )
              ),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              initialBinding: GetBinding(),
            ),
        designSize: const Size(480, 800));
  }
}

