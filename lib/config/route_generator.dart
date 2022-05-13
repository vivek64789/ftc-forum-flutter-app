import 'package:flutter/material.dart';
import 'package:ftc_forum/models/section.dart';
import 'package:ftc_forum/screens/homescreen/home_screen.dart';
import 'package:ftc_forum/screens/mainscreen/main_screen.dart';
import 'package:ftc_forum/screens/sections/section_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case SectionScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SectionScreen(
                  section: const Section(id: "", name: "Section Screen"),
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
