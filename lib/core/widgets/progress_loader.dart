import 'package:flutter/material.dart';

import '../../core/config/theme/app_theme.dart';


class ProgressLoader extends StatelessWidget {
  const ProgressLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(AppColorTheme.primary),
                    strokeWidth: 4.0,
                  ),
                )
              ],
            )));
  }
}
