import 'package:flutter/material.dart';
import 'package:flutter_app/page_controller.dart';
import 'drawer/drawer_screen.dart';
import 'drawer/menu_controller.dart';


var selectedMenuItemId, isLoading;

class Library extends StatefulWidget {
  Library();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LibraryState();
  }
}

class _LibraryState extends State<Library> with TickerProviderStateMixin {

  String primaryTitle = 'Antara';
  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  final menu = new Menu(
    items: [
      new MenuItem(
        id: '0',
        title: 'LIBRARY',
      ),
      new MenuItem(
        id: '1',
        title: 'CURRENT QUEUE',
      ),
      new MenuItem(
        id: '2',
        title: 'SETTINGS',
      ),
      new MenuItem(
        id: '3',
        title: 'HELP',
      ),
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedMenuItemId = '0';
    isLoading = true;
    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MenuScreen(
          menu: menu,
          currrentSelectedItemId: selectedMenuItemId,
          onMenuItemSelected: (String menuItemId) {
            setState(() {
              selectedMenuItemId = menuItemId;
                isLoading = false;
            });
          },
        ),
        foreGround(selectedMenuItemId),
      ],
    );
  }

  foreGround(menuItemId) {
    return zoomAndSlideForeGround(
      PageViewController(
        selectedMenuItemId: menuItemId,
        setIsLoading: isLoading,
      ),
    );
  }

  zoomAndSlideForeGround(Widget foreGround) {
    var slidePercent, scalePercent;

    switch (menuController.menuState) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
    }
    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xCF000000),
                offset: const Offset(0.0, 10.0),
                blurRadius: 15.0,
                spreadRadius: 10.0),
          ],
        ),
        child: ClipRRect(
          child: foreGround,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
      ),
    );
  }
}

typedef Widget ScaffoldBuilder(
    BuildContext context, MenuController menuController);

class ScaffoldMenuController extends StatefulWidget {
  final ScaffoldBuilder builder;

  ScaffoldMenuController({this.builder});

  @override
  ScaffoldMenuControllerState createState() {
    return new ScaffoldMenuControllerState();
  }
}

class ScaffoldMenuControllerState extends State<ScaffoldMenuController> {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = getMenuController(context);
    menuController.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    final scaffoldState = context
        .ancestorStateOfType(new TypeMatcher<_LibraryState>()) as _LibraryState;
    return scaffoldState.menuController;
  }

  _onMenuControllerChange() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, getMenuController(context));
  }
}
