import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tmdb_task/features/data/data_sources/local_data/constant_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:tmdb_task/app.dart';
import 'features/presentation/res/injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}



