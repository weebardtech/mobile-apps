import 'package:flutter/material.dart';
import 'package:weebird_app/features/notification/presentation/pages/notifications_tab.dart';
import 'package:weebird_app/features/settings/presentation/pages/settings_tab.dart';
import '../../../../core/config/theme/app_theme.dart';
import '../../../../presentation/views/bottom_tab_view/bottom_tabbed.dart';
import '../../../resume/presentation/pages/resume_profile_tab.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  final String email;

  const DashboardScreen({
    super.key,
    required this.userName,
    required this.email,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const ResumeProfileTab(),
    const NotificationsTab(),
    const SettingsTab(),
  ];

  @override
  void initState() {
    super.initState();
    // Log an analytics event when MainScreen is shown after user logs in
    _logMainScreenEvent();
    // Fetch the initial notification count
  }

  void _logMainScreenEvent() {
    // MainScreen.analytics.logEvent(
    //   name: 'main_screen_viewed',
    //   parameters: <String, dynamic>{
    //     'user_logged_in': true,
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.primaryDark,

      body: BottomTabbed(screen: screens),
    );
  }
}
