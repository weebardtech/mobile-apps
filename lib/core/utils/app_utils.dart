import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeFormatExtension on String {
  String formatTime24() {
    // Parse the time string to DateTime object
    DateTime dateTime = DateFormat('h:mm a').parse(this);
    // Format the DateTime object to desired time format
    String convertTime = DateFormat('HH:mm').format(dateTime);
    // Split the time into hours and minutes
    List<String> parts = convertTime.split(':');

    // Add leading zero to hours if necessary
    String hours = parts[0].padLeft(2, '0');

    // Combine hours and minutes with colon separator
    return '$hours:${parts[1]}';
  }

  String formatTime12() {
    // Parse the time string to DateTime object
    DateTime dateTime = DateFormat.Hm().parse(this);

    // Format the DateTime object to desired time format
    return DateFormat('h:mm a').format(dateTime);
  }
}

extension StringExtension on String {
  String formatText() {
    try {
      return split(' ').map((word) {
        if (word.length > 1) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        } else {
          return word.toUpperCase();
        }
      }).join(' ');
    } catch (e) {
      return this;
    }
  }
}

extension DateFormatExtension on String {
  String toIso8601Format() {
    // Parse the date string using DateFormat
    DateFormat inputFormat = DateFormat('MMMM dd, yyyy');
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');

    // Parse the date string to DateTime object
    DateTime date = inputFormat.parse(this);

    // Format the DateTime object to ISO 8601 format string
    return outputFormat.format(date);
  }
}

extension ContextExtensions on BuildContext {
  void showSnackBar(String message) {
    try {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      // Handle the case where ScaffoldMessenger.of(context) throws an exception
      // This could happen if the widget associated with the BuildContext is not mounted
      print('Failed to show SnackBar: $e');
    }
  }
}
