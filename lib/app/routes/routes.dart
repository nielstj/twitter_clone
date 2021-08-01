import 'package:flutter/widgets.dart';
import 'package:twitter_clone/app/app.dart';
import 'package:twitter_clone/home/home.dart';
import 'package:twitter_clone/login/login.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
