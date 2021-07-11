import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_eng_helper/providers/notes-provider.dart';
import 'package:my_eng_helper/screens/main-screen.dart';
import 'package:my_eng_helper/screens/new-word-screen.dart';
import 'package:my_eng_helper/screens/word-details-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NotesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'EngHelper',
        routes: {
          MainScreen.route: (_) => MainScreen(),
          NewNoteScreen.route: (_) => NewNoteScreen(),
          NoteDetailsScreen.route: (_) => NoteDetailsScreen(),
        },
        initialRoute: MainScreen.route,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: generateMaterialColor(
            Color.fromRGBO(69, 186, 53, 1),
          ),
          accentColor: generateMaterialColor(
            Color.fromRGBO(69, 186, 53, 1),
          ),
          primaryColor: generateMaterialColor(
            Color.fromRGBO(30, 30, 30, 1),
          ),
          disabledColor: Color.fromRGBO(51, 51, 51, 1),
          buttonColor: Colors.white,
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
          buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(69, 186, 53, 1),
            disabledColor: Color.fromRGBO(51, 51, 51, 1),
          ),
          cursorColor: generateMaterialColor(
            Color.fromRGBO(69, 186, 53, 1),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: generateMaterialColor(
              Color.fromRGBO(69, 186, 53, 1),
            ),
            selectionColor: generateMaterialColor(
              Color.fromRGBO(69, 186, 53, 1),
            ),
            selectionHandleColor: generateMaterialColor(
              Color.fromRGBO(69, 186, 53, 1),
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
