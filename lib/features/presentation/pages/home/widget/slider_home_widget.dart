import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tmdb_task/features/domain/model/movie/now_playing_model.dart';
import 'package:tmdb_task/features/domain/use_cases/controller/getx_home.dart';
import 'package:tmdb_task/features/presentation/res/loading.dart';
import 'package:tmdb_task/features/presentation/widgets/image_widget.dart';

class SliderHome extends GetWidget<GetHome> {
  SliderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((data) {
      NowPlayingModel nowPlayingModel = data;
      return SizedBox(
        height: 200.h,
        child: Swiper(
          itemHeight: 200,
          itemWidth: 200,
          duration: 200,
          scale: 0.8,
          fade: 0.8,
          itemCount: nowPlayingModel.results!.length,
          itemBuilder: (context, index) {
            Results result = nowPlayingModel.results![index];
            return Container(
                height: 200,
                width: 150,
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: Colors.black)
                  //  color: Colors.black.withOpacity(0.1),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ImageWidget(
                      img: result.posterPath.toString(),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(result.title??'',style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),),
                          Row(
                            children: [
                              const Icon(Icons.star_rate,color: Colors.yellow,),
                              Text(result.voteAverage.toString(),style: const TextStyle(color: Colors.white,fontSize: 16),),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
          autoplay: true,
        ),
      );
    }, onError: (value) {
      return Container(); /*Text(value.toString());*/
    },onLoading: Container(height: 200,child: Center(child: CircularProgressIndicator.adaptive()),));
  }
}
