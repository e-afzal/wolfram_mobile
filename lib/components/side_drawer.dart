import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    final sidebarItems = [
      {
        'text': 'Properties',
        'route': '/results',
      },
      {
        'text': 'Contact us',
        'route': '/contact',
      },
    ];

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
        child: ListView(
            padding: EdgeInsets.only(top: deviceHeight*.25),
            children: sidebarItems
                .map(
                  (eachItem) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        print('${eachItem['text']} tapped');
                        var route = eachItem['route'].toString();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, route);
                      },
                      child: Text(
                        '${eachItem['text']}',
                        style: TextStyle(
                            fontFamily: 'ANC-Demi',
                            fontSize: 40,
                            letterSpacing: .90),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
