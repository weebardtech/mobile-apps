import 'dart:math';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final List<String> names;
  final List<String> totalParticipants; // Total number of participants

  const CircleAvatarWidget({
    Key? key,
    required this.names,
    required this.totalParticipants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int remainingParticipants = totalParticipants.length - 4;
    bool showCircleAvatar = remainingParticipants > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Align the avatars to the end
      mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
      children: [
        // Build avatars for the first 4 participants
        for (int i = 0; i < names.length && i < 4; i++)
          _buildCircleAvatar(getInitials(names[i])),
        // Conditionally show or hide the CircleAvatar
        if (showCircleAvatar)
          _buildCircleAvatar('+${remainingParticipants.toString()}'),
      ],
    );
  }

  Widget _buildCircleAvatar(String text) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getRandomColor(),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

Color getRandomColor() {
  final Random random = Random();
  int r, g, b;

  // Generate random values for RGB with a minimum threshold
  do {
    r = random.nextInt(256);
    g = random.nextInt(256);
    b = random.nextInt(256);
  } while ((r + g + b) < 300); // Adjust the threshold as needed

  // Return a Color object with the generated RGB values
  return Color.fromARGB(255, r, g, b);
}

String getInitials(String name) {
  List<String> words = name.split(' ');
  List<String> initialsList = [];

  // Limit the number of initials to 2
  int maxInitials = 2;

  for (var word in words) {
    if (word.isNotEmpty && initialsList.length < maxInitials) {
      initialsList.add(word[0].toUpperCase());
    }
  }

  return initialsList.join('');
}
