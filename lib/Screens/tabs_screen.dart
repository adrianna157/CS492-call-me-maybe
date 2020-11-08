import 'package:guevarra_adrianna/screens/contact_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../screens/business_card.dart';
import '../screens/contact_me.dart';
import '../screens/resume.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  final String pageIndex;

  TabScreen({
    this.pageIndex,
  });

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> _widgets = <Widget>[
    BusinessCardScreen(),
    ResumeScreen(),
    ContactMeScreen(),
  ];

  int _defaultIndex = 0;
  int _selectedIndex;

  int _selectedPageIndex;

  void _onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text(
              'Business',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text(
              'Resume',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            title: Text(
              'Contact',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
        onTap: _onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Colors.white,
        iconSize: 25,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: BusinessCardScreen(),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: ResumeScreen(),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: ContactMeScreen(),
                );
              },
            );
        }
      },
    );
  }
}