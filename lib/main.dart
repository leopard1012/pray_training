import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Main';

  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            title: _title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue
            ),
            // home: MainPage(database, list, winList, winCounter),
            // home: MainPage(database, list, winList, winCounter),
            home: MainPage(true),
          );
        }
  }

