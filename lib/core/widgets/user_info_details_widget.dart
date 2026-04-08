import 'package:flutter/material.dart';

import '../../core/config/theme/app_theme.dart';


class UserInfoDetails extends StatelessWidget {
  final String details;
  final String info;
  const UserInfoDetails({super.key, required this.info, required this.details});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4, left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              width: 0.2,
              color: AppColorTheme.primary,
            ),
          ),
        ),
        child: Padding(
          padding:
           const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$info: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

                Expanded(
                  child: Text(
                    details,
                    style: TextStyle(fontSize: 16),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
