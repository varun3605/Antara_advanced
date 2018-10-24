import 'package:flutter/material.dart';
import 'library.dart';
import 'audioPlayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String per_rqst_status;
bool per_denied_permanently;
SharedPreferences preferences;

class PermissionPage extends StatefulWidget {
  _PermissionState createState() {
    return new _PermissionState();
  }
}

class _PermissionState extends State<PermissionPage> {
  final GlobalKey<ScaffoldState> mScaffoldstate = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkPerstatus();
  }

  void chkPerstatus() async{
    preferences = await SharedPreferences.getInstance();
    per_denied_permanently = (preferences.getBool('per_denied_perm') ?? false);
    if (per_denied_permanently) {
      per_rqst_status = "PERMISSION_DENIED_PERMANENTLY";
      getPerstatus();
    }
    else {
      checkPermissions();
    }
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

  void getPerstatus()
  {
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
        child: Text('Permissions'),
      ),
    );
  }
}
