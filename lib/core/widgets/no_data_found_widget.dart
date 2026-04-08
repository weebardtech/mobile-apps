import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoDataFound extends StatelessWidget {
  String text;
  NoDataFound({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     detail,
          //     style: TextStyle(
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
