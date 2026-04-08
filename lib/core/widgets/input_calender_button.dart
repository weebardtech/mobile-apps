import 'package:flutter/material.dart';

class InputCalenderButton extends StatelessWidget {
  final String hintText;
  final Function onPress;
  final textColor;

  const InputCalenderButton({
    super.key,
    required this.hintText,
    required this.onPress,
    this.textColor = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ButtonTheme(
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              side: BorderSide(width: 1, color: Colors.black),
              //padding: EdgeInsets.all(0)
            ),
            onPressed: () {
              onPress();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  hintText,
                  style: TextStyle(
                    color: textColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            )),
      ),
    );
  }
}
