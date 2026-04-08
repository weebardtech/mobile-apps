import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeebirdCustomWidget extends StatelessWidget {
  final double topPadding;

  const WeebirdCustomWidget({Key? key, this.topPadding = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Designed & Developed by'),
          const SizedBox(width: 8.0),
          SvgPicture.asset(
            'assets/logo/main_logo.svg',
            height: 10.0,
            width: 10.0,
            allowDrawingOutsideViewBox: true),
        ],
      ),
    );
  }
}
