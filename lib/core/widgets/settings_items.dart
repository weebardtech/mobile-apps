import 'package:flutter/material.dart';

import '../../core/config/theme/app_theme.dart';


class SettingsItems extends StatelessWidget {
  final IconData icons;
  final String title;

  const SettingsItems({Key? key, required this.icons, required this.title})
      : super(key: key);

  // Icons.lock_outline
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icons,
            size: 24,
            color: AppColorTheme.secondary,
          ),
          const SizedBox(width: 12.0), // Add SizedBox for spacing
          Expanded(
            // Wrap Row with Expanded
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xfffB8B8B8),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
