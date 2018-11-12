import 'dart:async';
import 'themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/homepage.dart';
import 'package:flutter_app/library.dart';
import 'audioPlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String perRequestStatus;
bool perDeniedPermanently;
SharedPreferences preferences;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: defaultTheme, //1. Select Theme for App TODO: Make an arrangement to load theme from Shared Preferences
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(), //2. Current Opening Hello Page TODO: Implement Logo Animation
      routes: <String, WidgetBuilder>{
        '/HomePage': (BuildContext context) {
          return new HomePage();
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashState createState() {
    return new SplashState();
  }
}

class SplashState extends State<SplashScreen> {

  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkFirstTime(); //3. Checking whether the App is opening First Time
  }

  Future checkFirstTime() async {
    preferences = await SharedPreferences.getInstance();
    bool _opened = (preferences.getBool('opened') ?? false); //4. If opening for First Time, then assign false; else get from Shared Preferences

    if (_opened) {
      startTimeSecond();
    } else {
      startTimeOne();
    }
  }

  startTimeOne() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, nextPage);
  }

  void nextPage() {
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  startTimeSecond() async{ //5. Inflate MainPage
    var duration = new Duration(seconds: 2);
    return new Timer(duration, mainPage);
  }

  void mainPage()
  {
    checkPermissions(); //6. Check Permissions
  }


  void checkPermissions() async {

    perRequestStatus = await AudioExtractor.requestPermission(1);//7. Request Permissions with code 1
    getPerStatus();
  }

  void getPerStatus() async {
    switch (perRequestStatus) {
      case "PERMISSION_GRANTED":
        print("Permission is granted");
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return new Library();
        }));
        break;
      case "PERMISSION_DENIED":
        print("Permission is Denied");
        final snackBar = SnackBar(
          content: Text("Permission necessary to access songs!!"),
          action: SnackBarAction(label: 'Enable', onPressed: checkPerDenied),
          duration: new Duration(seconds: 10),
        );
        mScaffoldState.currentState.showSnackBar(snackBar);
        break;
      case "PERMISSION_DENIED_PERMANENTLY":
        print("Permission denied permanently");
        preferences.setBool('per_denied_perm', true);
        final snackBar = SnackBar(
          content: Text("Please grant permission from settings"),
          action: SnackBarAction(label: 'Open', onPressed: openSettings),
          duration: new Duration(seconds: 10),
        );
        mScaffoldState.currentState.showSnackBar(snackBar);
        break;
      default:
        print("A error occurred");
    }
  }

  void checkPerDenied() async
  {
    perRequestStatus = await AudioExtractor.requestPermission(2);
    getPerStatus();
  }

  void openSettings() async
  {
    perRequestStatus = await AudioExtractor.openSettings();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: mScaffoldState,
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
