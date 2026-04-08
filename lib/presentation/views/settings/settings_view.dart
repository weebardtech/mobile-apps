import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/config/routes/app_router.dart';
import '../../../core/config/theme/app_theme.dart';
import '../../../core/widgets/settings_items.dart';
import '../../../data/session_manager/user_prefs_manager.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../business_logic/blocs/user_logout/user_logout_bloc.dart';
import '../../../core/network/internet_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final UserPrefsManager userPrefsManager = UserPrefsManager();

  late bool notificationEnabled = false; // Initialize with a default value

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    // Load the initial state of the notification switch
    _loadNotificationState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  // Future<void> _fetchVersionInfo() async {
  //   try {
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     setState(() {
  //       version = packageInfo.version;
  //       buildNumber = packageInfo.buildNumber;
  //     });
  //     print('Version: $version, Build: $buildNumber');
  //   } catch (e) {
  //     print('Error fetching package info: $e');
  //   }
  // }

  Future<void> _loadNotificationState() async {
    bool hasNotification = await userPrefsManager.hasNotification();
    if (hasNotification) {
      bool isEnabled = await userPrefsManager.getNotificationState();
      setState(() {
        notificationEnabled = isEnabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onLogoutButtonPressed() {
      final authBloc = context.read<AuthBloc>().state;

      if (authBloc is Authorized) {
        BlocProvider.of<UserLogoutBloc>(
          context,
        ).add(UserLogoutButtonPressed(token: 'authBloc.token'));
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetDisconnected) {
              String errorMessage = "No Internet Connection!";

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ),
        BlocListener<UserLogoutBloc, UserLogoutState>(
          listener: (context, state) {
            if (state is UserLogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is UserLogoutInitial) {
              // print("logout initial---");
            }

            if (state is UserLogoutEmptyData) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Enter Employee ID or Password!"),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is UserLogoutSuccess) {
              // Example: SharedPreferences.getInstance().clear();

              // Unsubscribe from notifications or any other cleanup
              //MessagingService().unsubscribeFromNotifications();

              // Dispatch the LoggedOut event to AuthBloc
              // BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            }
          },
        ),
      ],
      child: BlocBuilder<UserLogoutBloc, UserLogoutState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
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
                                  width: 0.5,
                                  color: Color(0xfffB8B8B8),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Notification',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CupertinoSwitch(
                                    value: notificationEnabled,
                                    activeColor: AppColorTheme.primary,
                                    onChanged: (value) async {
                                      setState(() {
                                        notificationEnabled = value;
                                      });
                                      // Store the notification switch state
                                      await userPrefsManager
                                          .setNotificationState(value);
                                      // Toggle notification status
                                      //MessagingService().toggleNotifications(value);
                                      // Display a snackbar
                                      String message = value
                                          ? 'Notification On'
                                          : 'Notification Off';
                                      Color snackBarColor = value
                                          ? Colors.green
                                          : Colors.red;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                          backgroundColor: snackBarColor,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const SettingsItems(
                      icons: Icons.lock_outline,
                      title: 'Privacy and Security',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const SettingsItems(
                      icons: Icons.support_agent,
                      title: 'Help and support',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const SettingsItems(
                      icons: Icons.question_mark_rounded,
                      title: 'About Us',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.home);
                    },
                    child: SettingsItems(
                      icons: Icons.key_rounded,
                      title: 'Change Password',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                            "Are you sure you want to logout",
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: AppColorTheme.primary,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColorTheme.primary,
                                    backgroundColor: AppColorTheme.primary,
                                  ),
                                  onPressed: () {
                                    onLogoutButtonPressed();
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    child: const Text(
                                      "Ok",
                                      style: TextStyle(
                                        color: AppColorTheme.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    child: SettingsItems(icons: Icons.logout, title: 'Logout'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Text('Version: ${_packageInfo.version}'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
