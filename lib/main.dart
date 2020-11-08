import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './models/resume_provider.dart';

import './screens/tabs_screen.dart';
import './screens/business_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight, DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Resumes(),
        ),
      ],
      child: MaterialApp(
        title: 'Call Me Maybe Project',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pinkAccent,
          canvasColor: Color.fromRGBO(250, 245, 240, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        home: TabScreen(),
        routes: {
          BusinessCardScreen.routeName: (context) => BusinessCardScreen(),
        },
      ),
    );
  }
}
