import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:upgrader/upgrader.dart';
import 'package:weebird_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:weebird_app/features/auth/presentation/pages/onboarding_auth_screen.dart';
import 'package:weebird_app/presentation/business_logic/blocs/user_list_bloc/bloc/user_list_bloc_bloc.dart';
import 'package:weebird_app/presentation/business_logic/blocs/user_logout/user_logout_bloc.dart';
import 'package:weebird_app/core/network/internet_cubit.dart';

import 'package:weebird_app/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

import 'core/config/routes/route_generator.dart';
import 'core/config/theme/app_theme.dart';
import 'data/api/api_client.dart';
import 'data/repositories/user_list_repository.dart';
import 'data/repositories/user_logout_repository.dart';
import 'data/session_manager/user_prefs_manager.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await Upgrader.clearSavedSettings();

  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  di.init();
  runApp(
    MyApp(
      //analytics: analytics,
    ),
  );
}

class MyApp extends StatelessWidget {
  //final FirebaseAnalytics analytics; // Declare Firebase Analytics instance
  final userPrefs = UserPrefsManager();

  MyApp({
    super.key,
    //required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: Connectivity()),
        ),

        BlocProvider<UserListBlocBloc>(
          create: (blockContext) =>
              UserListBlocBloc(UserListRepository(APIClient())),
        ),

        BlocProvider<UserLogoutBloc>(
          create: (blockContext) =>
              UserLogoutBloc(UserLogoutRepository(APIClient())),
        ),
      ],
      child: MaterialApp(
        title: 'WeeBird',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyAppStart(userPrefsManager: userPrefs),
      ),
    );
  }
}

class MyAppStart extends StatefulWidget {
  final UserPrefsManager userPrefsManager;

  const MyAppStart({Key? key, required this.userPrefsManager})
    : super(key: key);

  @override
  State<MyAppStart> createState() => _MyAppStartState();
}

class _MyAppStartState extends State<MyAppStart> {
  //final _messagingService = MessagingService();
  String? _installedVersion;

  @override
  void initState() {
    super.initState();
    _initializeVersion();
    context.read<AuthBloc>().add(AppStarted());
  }

  Future<void> _initializeVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _installedVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    const appcastURL =
        'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generate,
      home: UpgradeAlert(
        showLater: true,
        showIgnore: true,
        shouldPopScope: () => true,
        dialogStyle: kIsWeb
            ? UpgradeDialogStyle
                  .material // Choose one for web
            : (defaultTargetPlatform == TargetPlatform.android
                  ? UpgradeDialogStyle.material
                  : UpgradeDialogStyle.cupertino),
        upgrader: Upgrader(
          storeController: UpgraderStoreController(
            // onAndroid: () => UpgraderAppcastStore(appcastURL: appcastURL, osVersion: '1.0.0'),
          ),
          //minAppVersion: '1.0.0',
          willDisplayUpgrade: ({required display, installedVersion, versionInfo}) {
            // Check if the current version matches the specified version

            if (_installedVersion != null && installedVersion != null) {
              if (_installedVersion == installedVersion) {
                display =
                    false; // Do not display the upgrade dialog if versions match
              }
            }
          },
          debugLogging: true,
          debugDisplayAlways: false,
          debugDisplayOnce: true,
          durationUntilAlertAgain: const Duration(hours: 2),
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return DashboardScreen(
                userName: 'state.userName',
                email: 'test@gmail.com',
              );
            }

            if (state is Unauthorized) {
              return OnboardingAuthScreen();
            }
            if (state is AuthLoading) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColorTheme.primary,
                    ),
                  ),
                ),
              );
            }
            return Container(); // Return an empty container if state is undefined
          },
        ),
      ),
    );
  }
}
