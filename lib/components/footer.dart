import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();

  final marginTop;
  Footer({this.marginTop = 0.0});
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: widget.marginTop),
      padding: EdgeInsets.symmetric(vertical: 60),
      color: Colors.black,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // LOGO Image
          Image.asset(
            'assets/image/home/logo-white-vertical.png',
            fit: BoxFit.cover,
            height: 110,
          ),

          SizedBox(height: 10),

          // Copyright text
          Padding(
            padding: const EdgeInsets.only(top: 17, bottom: 25),
            child: Text(
              'Wolfram Realty 2021. All Rights Reserved.',
              style: TextStyle(
                  color: Color(0xffbebfc1),
                  fontFamily: 'ANC-Regular',
                  fontSize: 17),
            ),
          ),

          // Social Media Logos
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Image.asset(
                  'assets/icon/Home/Facebook.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Image.asset(
                  'assets/icon/Home/Twitter.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Image.asset(
                  'assets/icon/Home/Linkedin.png',
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                'assets/icon/Home/Youtube.png',
                fit: BoxFit.cover,
              ),
            ],
          )
        ],
      ),
    );
  }
}
