import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_task/features/data/data_sources/local_data/constant_data.dart';
import 'package:tmdb_task/features/data/remote_data/core.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget(
      {Key? key,
      required this.img,
      this.holder = 'images/error.png',
      this.circle = 10.0})
      : super(key: key);
  String img;
  String holder;
  double circle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circle),
      child: Container(
        color: staticColor,
        child: FadeInImage(
            fit: BoxFit.cover,
            image: ResizeImage(
              CachedNetworkImageProvider(
                apiUrlImage() + img,
              ),
              width: MediaQuery.of(context).size.width.toInt(),
            ),
            placeholder: AssetImage('images/picture.png'),
            // placeholder image until finish loading
            imageErrorBuilder: (context, error, st) {
              return Image.asset(holder);
            }),
      ),
    );
  }
}
