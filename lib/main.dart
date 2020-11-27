import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:loadoperator/providers/user_account_provider.dart';
import 'package:loadoperator/screens/Add_points_screen/Add_points.dart';
import 'package:loadoperator/screens/Main_screen/main_screen.dart';
import 'package:loadoperator/screens/login_screen/login.dart';
import 'package:loadoperator/screens/scanned_reward/scanned.dart';
import 'package:loadoperator/screens/splash_screen/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAccountProvider()),
      ],
      child: DevicePreview(enabled: false, builder: (builder) => MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: appThemeRed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: DevicePreview.appBuilder,
      routes: {
        '/': (_) => Splashscreen(),
        Mainscreen.routeName: (_) => Mainscreen(),
        Login.routeName: (_) => Login(),
        Addpoints.routeName: (_) => Addpoints(),
        Scannedreward.routeName: (_) => Scannedreward(),
      },
    );
  }

  MaterialColor appThemeRed = const MaterialColor(
    0XFFEE4036,
    const <int, Color>{
      50: const Color(0XFFEE4036),
      100: const Color(0XFFEE4036),
      200: const Color(0XFFEE4036),
      300: const Color(0XFFEE4036),
      400: const Color(0XFFEE4036),
      500: const Color(0XFFEE4036),
      600: const Color(0XFFEE4036),
      700: const Color(0XFFEE4036),
      800: const Color(0XFFEE4036),
      900: const Color(0XFFEE4036),
    },
  );
}
