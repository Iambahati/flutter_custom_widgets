
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Advance',
      theme: FlexThemeData.light(scheme: FlexScheme.mallardGreen),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mallardGreen),
      // themeMode: ThemeMode.light,
      home: const App(),
    );
  }
}