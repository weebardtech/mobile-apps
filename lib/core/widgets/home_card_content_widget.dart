import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/config/theme/app_theme.dart';


class HomeCardContentWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String count;

  const HomeCardContentWidget(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: AppColorTheme.primary_light,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(count),
            ],
          ),
        ),
      ),
    );
  }
}
