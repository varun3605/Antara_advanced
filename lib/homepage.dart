import 'package:flutter/material.dart';
import 'permission_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Welcome to Antara'),
          onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setBool('opened', true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return new PermissionPage();
              }),
            );
          },
        ),
      ),
    );
  }
}
