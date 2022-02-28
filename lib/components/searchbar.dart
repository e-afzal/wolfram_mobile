// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:wolfram/screen/search_results.dart';

// 3RD PARTY PACKAGES
import 'package:fluttertoast/fluttertoast.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  var fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cancel_outlined,
            color: Colors.black,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            "Please enter a valid search term",
            style: TextStyle(fontFamily: 'ANC-Regular', color: Colors.black),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Color(0xff31343a),
      style: TextStyle(
          color: Color(0xff31343a), fontFamily: 'ANC-Regular', fontSize: 19),
      onFieldSubmitted: (val) {
        if (val.trim().length == 0) {
          showToast();
          return;
        }

        // Navigate to 'Results' page
        var route = MaterialPageRoute(
            builder: (ctx) => SearchResults(query: val.trim()));
        Navigator.push(context, route);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6.5),
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 20, 20, 20),
        prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: Icon(
              Icons.search,
              color: Color(0xff31343a),
              size: 25,
            )),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Search property..',
        hintStyle: TextStyle(
            color: Color(0xff31343a), fontFamily: 'ANC-Regular', fontSize: 19),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
