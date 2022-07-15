import 'package:flutter/material.dart';
import 'package:keep_task/config/themes.dart';

class TopRightCliper extends StatelessWidget {
  TopRightCliper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 32,
            child: Image.asset('assets/images/topclip.png'),
          ),
          Positioned(
            top: 32,
            child: Image.asset('assets/images/rtopclip.png'),
          ),
        ],
      ),
    );
  }
}
