import 'package:flutter/material.dart';
import 'package:ftc_forum/blocs/app/app_bloc.dart';
import 'package:ftc_forum/screens/screens.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];

    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
