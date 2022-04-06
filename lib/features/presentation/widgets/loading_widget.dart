import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'as kit;
import 'package:tmdb_task/features/data/data_sources/local_data/constant_data.dart';



var spinkit = const kit.SpinKitRotatingCircle(
  color: staticColor,
  size: 30.0,
);

var waveKit = const kit.SpinKitWave(
  color: staticColor,
  size: 30.0,
);

var ringKit = kit.RingPainter(
    trackColor: staticColor,
    paintWidth: 30
);

var threeBounce = const kit.SpinKitThreeBounce(
  color: staticColor,
  size: 30,
);