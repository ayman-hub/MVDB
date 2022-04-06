import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';

import 'package:tmdb_task/features/domain/use_cases/controller/getx_home.dart';
import 'package:tmdb_task/features/presentation/pages/home/widget/card_widget.dart';
import 'package:tmdb_task/features/presentation/res/context.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';
import 'package:tmdb_task/features/presentation/widgets/image_widget.dart';

class BodyHome extends GetWidget<GetHome> {
  BodyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Context _context = Context(context);
    return controller.obx((data) {
      NowPlayingModel nowPlayingModel = data;
      return Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 5),
              child: const Text(
                'NEW PLAYING',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.left,
              )),
          const SizedBox(
            height: 5,
          ),
          ...nowPlayingModel.results!.map((e) => SizedBox(
              height: 150,
              child: CardWidget(data: e,addToWatchList: true,))).toList()
        ],
      );
    }, onError: (value) {
      return Container(
          height:_context.getHeight() ,
          alignment: Alignment.center,
          child: Text(value.toString(),style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,));
    },onLoading: const Center(child: CupertinoActivityIndicator()));
  }
}


