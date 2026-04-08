import 'package:flutter/material.dart';

class DropdownFromField extends StatelessWidget {
  final String value;

  final List<String> items;
  final Function(String) onChange;

  const DropdownFromField(
      {super.key,
      required this.value,
      required this.items,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        //labelText: 'Select an option',
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0), // Set border radius here
        ),
      ), // dropdownColor: Colors.greenAccent,
      value: value,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),

      onChanged: (String? newValue) {
        onChange(newValue!);
      },
    );
  }
}
