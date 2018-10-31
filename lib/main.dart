import 'dart:async';
import 'themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/homepage.dart';
import 'package:flutter_app/library.dart';
import 'audioPlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String per_rqst_status;
bool per_denied_permanently;
SharedPreferences preferences;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: Default,
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
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

  final GlobalKey<ScaffoldState> mScaffoldstate = new GlobalKey<ScaffoldState>();

  Future checkFirstTime() async {
    preferences = await SharedPreferences.getInstance();
    bool _opened = (preferences.getBool('opened') ?? false);

    if (_opened) {
      startTimeSecond();
    } else {
      startTimeOne();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstTime();
  }

  startTimeOne() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, nextPage);
  }

  startTimeSecond() async{
    var duration = new Duration(seconds: 2);
    return new Timer(duration, mainPage);
  }

  void mainPage()
  {
    checkPermissions();
  }
  void nextPage() {
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  void checkPermissions() async {

    per_rqst_status = await AudioExtractor.requestPermission(1);
    getPerstatus();
  }

  void check_per_denied() async
  {
    per_rqst_status = await AudioExtractor.requestPermission(2);
    getPerstatus();
  }

  void open_settings() async
  {
    per_rqst_status = await AudioExtractor.openSettings();
  }

  void getPerstatus() async {
    switch (per_rqst_status) {
      case "PERMISSION_GRANTED":
        print("Permission is granted");
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          return new Library();
        }));
        break;
      case "PERMISSION_DENIED":
        print("Permission is Denied");
        final snackbar = SnackBar(
          content: Text("Permission necessary to access songs!!"),
          action: SnackBarAction(label: 'Enable', onPressed: check_per_denied),
          duration: new Duration(seconds: 10),
        );
        mScaffoldstate.currentState.showSnackBar(snackbar);
        break;
      case "PERMISSION_DENIED_PERMANENTLY":
        print("Permission denied permanently");
        preferences.setBool('per_denied_perm', true);
        final snackbar = SnackBar(
          content: Text("Please grant permission from settings"),
          action: SnackBarAction(label: 'Open', onPressed: open_settings),
          duration: new Duration(seconds: 10),
        );
        mScaffoldstate.currentState.showSnackBar(snackbar);
        break;
      default:
        print("A error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: mScaffoldstate,
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
