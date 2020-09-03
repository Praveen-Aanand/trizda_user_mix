import 'package:flutter/material.dart';
import 'package:trizda_user/elements/Comment.dart';
// import '../elements/DrawerWidget.dart';
// import '../elements/FilterWidget.dart';
import '../models/route_argument.dart';
import './home.dart';
// import '../pages/favorites.dart';
// import '../pages/home.dart';
import 'loginpage.dart';
import 'map.dart';
import 'map.dart';
import 'favorites.dart';
// import '../pages/notifications.dart';
// import '../pages/orders.dart';

class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument routeArgument;
  Widget currentPage = Home();
  // Widget currentPage = Text("data");

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  @override
  void initState() {
    pageList.add(Home());
    pageList.add(MapWidget());
    pageList.add(LoginPage());
    pageList.add(Comment());
    super.initState();
  }

  // void _selectTab(int tabItem) {
  //   setState(() {
  //     widget.currentTab = tabItem;
  //     switch (tabItem) {
  //       // case 0:
  //       //   widget.currentPage = NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
  //       //   break;
  //       // case 1:
  //       //   widget.currentPage = MapWidget(parentScaffoldKey: widget.scaffoldKey, routeArgument: widget.routeArgument);
  //       //   break;
  //       // case 2:
  //       //   widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
  //       //   break;
  //       // case 3:
  //       //   widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
  //       //   break;
  //       // case 4:
  //       //   widget.currentPage = FavoritesWidget(parentScaffoldKey: widget.scaffoldKey);
  //       //   break;
  //       case 2:
  //         widget.currentPage = Text("hello");
  //         break;
  //       case 1:
  //         widget.currentPage = Text("he");
  //         break;
  //     }
  //   });
  // }

  List<Widget> pageList = List<Widget>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: widget.scaffoldKey,
          // drawer: DrawerWidget(),
          // endDrawer: FilterWidget(onFilter: (filter) {
          //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: widget.currentTab);
          // }),
          body: IndexedStack(
            index: widget.currentTab,
            children: pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).accentColor,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 22),
            unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
            // currentIndex: widget.currentTab,
            // onTap: (int i) {
            //   this._selectTab(i);
            // },
            // this will be set when a new tab is tapped
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                title: Text('Store'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Orders'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Account'),
              ),
            ],
            currentIndex: widget.currentTab,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.currentTab = index;
    });
  }
}
