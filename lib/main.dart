import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as color;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:google_fonts/google_fonts.dart';
import 'package:saino/view/other_page/form_data.dart';

import 'view/home_page.dart/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.dark,
            /* set Status bar icons color in Android devices.*/
            systemNavigationBarColor: Colors.transparent,
            /* set Status bar icons color in Android devices.*/
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );

    return MaterialApp(
        title: 'Saino',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kPrimaryColor,
          fontFamily: GoogleFonts.notoSans().fontFamily,
        ),
        home: HomePage(),
        routes: {
          FormData.routeName: (_) => FormData(),
        });
  }
}

const green = color.Color(0xff117660);
const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF117660,
  const <int, Color>{
    50: green,
    100: green,
    200: green,
    300: green,
    400: green,
    500: green,
    600: green,
    700: green,
    800: green,
    900: green,
  },
);
