import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/ui/splash/splash_page.dart';

import 'data/injection_container.dart';

void main() {
  initKiwi();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage());
  }
}
