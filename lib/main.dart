import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:finalpdf/pages/home/homePage.dart';
import 'package:finalpdf/pages/screen/mains.dart';
import 'package:finalpdf/pages/setting/settings.dart';
import 'package:finalpdf/widgets/constant.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'data.dart';
import 'package:flutter/material.dart';
import 'widgets/header.dart';

void main(){
  // await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MaterialApp(
    home: const MyApp(),
    theme: ThemeData(fontFamily: 'Circular'),
    debugShowCheckedModeBanner: false,
  ));
}



class MyApp extends StatelessWidget {

  static const String title = 'Light & Dark Theme';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeChange(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeChange>(context);

          return MaterialApp(
            title: title,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const MainScreen(),
          );
        },
      );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: <Widget>[
          Image.asset('images/unnamed.png'),
          const Text('SMART PDF', style:
          TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white
          ),)
        ],
      ),
      backgroundColor: ContentColorDarkTheme,
      nextScreen: const MainScreen(),
      splashIconSize: 250,
      duration: 3000,
      // splashTransition: SplashTransition.fadeTransition,
    );
  }
  
}

