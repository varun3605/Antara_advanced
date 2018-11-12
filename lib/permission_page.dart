import 'package:flutter/material.dart';
import 'library.dart';
import 'audioPlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String perRequestStatus;
bool perDeniedPermanently;
SharedPreferences preferences;

class PermissionPage extends StatefulWidget {
  _PermissionState createState() {
    return new _PermissionState();
  }
}

class _PermissionState extends State<PermissionPage>
{

  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkPerStatus();
  }

  void chkPerStatus() async{
    preferences = await SharedPreferences.getInstance();
    perDeniedPermanently = (preferences.getBool('per_denied_perm') ?? false);
    if (perDeniedPermanently) {
      perRequestStatus = "PERMISSION_DENIED_PERMANENTLY";
      getPerStatus();
    }
    else {
      checkPermissions();
    }
  }

  void checkPermissions() async {

    perRequestStatus = await AudioExtractor.requestPermission(1);
    getPerStatus();
  }

  void getPerStatus()
  {
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
        child: Text('Permissions'),
      ),
    );
  }
}
