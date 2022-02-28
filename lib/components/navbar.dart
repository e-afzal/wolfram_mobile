import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();

  final bgdColor;
  Navbar({this.bgdColor});
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        color: widget.bgdColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Image.asset(
                      'assets/icon/Home/Navbar.png',
                      height: 75,
                    ))),
            Image.asset(
              'assets/image/home/logo-2x.png',
              height: 65,
              fit: BoxFit.contain,
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
