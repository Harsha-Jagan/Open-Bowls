import 'package:flutter/material.dart';
import 'package:frontend/core/notifiers.dart';
import 'package:frontend/widget_tree.dart';

class Wraphome extends StatelessWidget {
  const Wraphome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, isDark, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Open Arms',
            theme: ThemeData(
              brightness: isDark ? Brightness.dark : Brightness.light,
              useMaterial3: true,
            ),
            home: const WidgetTree(),
          );
        });
  }
}
