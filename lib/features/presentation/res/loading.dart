import 'package:flutter/material.dart';
import 'package:tmdb_task/features/presentation/widgets/loading_widget.dart';

class ProgressPage extends StatelessWidget {
  ProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: waveKit,
    );
  }
}
