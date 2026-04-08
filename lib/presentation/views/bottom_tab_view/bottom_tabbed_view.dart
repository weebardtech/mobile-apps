import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../core/config/theme/app_theme.dart';


class BottomTabbedView extends StatefulWidget {
  final List<Widget> screen;

  const BottomTabbedView({super.key, required this.screen});

  @override
  State<BottomTabbedView> createState() => _BottomTabbedViewState(screens: screen);
}
class _BottomTabbedViewState extends State<BottomTabbedView> {
  int _selectedIndex = 0;
  final List<Widget> screens;

  _BottomTabbedViewState({required this.screens});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColorTheme.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),

            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: GNav(
              haptic: true,
              backgroundColor: Colors.transparent, // ✅ transparent for curved bg
              color: const Color(0xff999999),
              activeColor: AppColorTheme.white,
              tabBorderRadius: 12,
              tabBackgroundColor: AppColorTheme.gray,
              gap: 4,
              selectedIndex: _selectedIndex,
              tabs: [
                GButton(
                  icon: Icons.circle,
                  leading: SvgPicture.asset(
                    'assets/icons/ic_home.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 0 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.circle,
                  leading: SvgPicture.asset(
                    'assets/icons/ic_resume.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  text: 'Resume',
                ),
                GButton(
                  icon: Icons.circle,
                  leading: SvgPicture.asset(
                    'assets/icons/ic_notification.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 2 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  text: 'Notification',
                ),
                GButton(
                  icon: Icons.circle,
                  leading: SvgPicture.asset(
                    'assets/icons/ic_settings.svg',
                    colorFilter: ColorFilter.mode(
                      _selectedIndex == 3 ? Colors.white : Colors.grey,
                      BlendMode.srcIn,
                    ),
                    height: 24,
                    width: 24,
                  ),
                  text: 'Settings',
                ),
              ],
              onTabChange: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
        ),

      ),
    );
  }
}
