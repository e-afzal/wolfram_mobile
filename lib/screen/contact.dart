// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:wolfram/components/footer.dart';

// THIRD PARTY PACKAGES
import 'package:fluttertoast/fluttertoast.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var fToast;
  String connectText =
      'We invite you to provide us with feedback or contact a specific department with any queries you might have.';
  String defaultQuestion = "Rent a property";
  List<String> queryList = [
    "Rent a property",
    "Purchase a property",
    "List/sell a property",
    "Discuss about advertising &/or sponsorship",
    "Give a general feedback"
  ];
  String name = '';
  String email = '';
  int number = 0;
  String message = '';

  void showToast(String message, IconData icon) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(fontFamily: 'ANC-Regular', color: Colors.black),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Contact us',
          style: TextStyle(fontFamily: 'ANC-Medium'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SECTION: Connect with us
                  Center(
                    child: Text('Connect with us',
                        style: TextStyle(
                            fontFamily: 'ANC-Medium',
                            fontSize: 26,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 10),
                  Text(connectText,
                      style: TextStyle(
                          height: 1.45,
                          fontFamily: 'ANC-Regular',
                          fontSize: 17,
                          color: Colors.black)),

                  // EMAIL & NUMBER
                  SizedBox(height: 25),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.phone, size: 20),
                        ),
                        Text('+971 4 319 8181',
                            style: TextStyle(
                                height: 1.45,
                                fontFamily: 'ANC-Regular',
                                fontSize: 17,
                                color: Colors.black))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.mail, size: 20),
                        ),
                        Text('info@wolframrealty.com',
                            style: TextStyle(
                                height: 1.45,
                                fontFamily: 'ANC-Regular',
                                fontSize: 17,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  // SECTION: Questions
                  Divider(height: 40, color: Colors.grey),
                  Center(
                    child: Text('Have questions?',
                        style: TextStyle(
                            fontFamily: 'ANC-Medium',
                            fontSize: 26,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 20),

                  // CHOICE LIST
                  Text('Would you like to:',
                      style: TextStyle(
                          fontFamily: 'ANC-Regular',
                          fontSize: 18,
                          color: Colors.black)),
                  DropdownButton<String>(
                    value: defaultQuestion,
                    isExpanded: true,
                    style: TextStyle(
                        color: Color(0xff31343a),
                        fontSize: 16,
                        fontFamily: 'ANC-Medium'),
                    dropdownColor: Color(0xfff1f1f1),
                    onChanged: (String? newValue) {
                      setState(() {
                        defaultQuestion = newValue!;
                      });
                      print(defaultQuestion);
                    },
                    items: queryList
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  // NAME FIELD
                  TextFormField(
                    cursorColor: Color(0xff31343a),
                    style: TextStyle(
                        color: Color(0xff31343a),
                        fontFamily: 'ANC-Regular',
                        fontSize: 18),
                    onChanged: (val) {
                      setState(() {
                        name = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'ANC-Regular',
                          fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  SizedBox(height: 20),

                  // EMAIL FIELD
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Color(0xff31343a),
                    style: TextStyle(
                        color: Color(0xff31343a),
                        fontFamily: 'ANC-Regular',
                        fontSize: 18),
                    onChanged: (val) {
                      setState(() {
                        email = val.trim();
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'ANC-Regular',
                          fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  SizedBox(height: 20),

                  // NUMBER FIELD
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Color(0xff31343a),
                    style: TextStyle(
                        color: Color(0xff31343a),
                        fontFamily: 'ANC-Regular',
                        fontSize: 18),
                    onChanged: (val) {
                      setState(() {
                        number = int.parse(val);
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your contact number',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'ANC-Regular',
                          fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  SizedBox(height: 20),

                  // MESSAGE FIELD
                  TextFormField(
                    maxLines: 10,
                    cursorColor: Color(0xff31343a),
                    style: TextStyle(
                        color: Color(0xff31343a),
                        fontFamily: 'ANC-Regular',
                        fontSize: 18),
                    onChanged: (val) {
                      setState(() {
                        message = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(4.5),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 20, 15),
                      fillColor: Colors.grey[200],
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'ANC-Regular',
                          fontSize: 18),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  SizedBox(height: 30),

                  // SUBMIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      autofocus: false,
                      clipBehavior: Clip.none,
                      onPressed: () async {
                        if (name.isEmpty ||
                            email.isEmpty ||
                            number == 0 ||
                            number.isNaN ||
                            message.isEmpty) {
                          showToast('Ensure all fields are accurate/complete',
                              Icons.warning);
                        } else {
                          showToast(
                              'Query submitted successfully!', Icons.check);
                          await Future.delayed(Duration(seconds: 4), () {
                            Navigator.pushReplacementNamed(context, '/contact');
                          });
                        }
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontFamily: 'ANC-Medium',
                            fontSize: 18.0,
                            letterSpacing: 0.5),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff31343a))),
                    ),
                  ),
                ],
              ),
            ),

            // FOOTER
            Footer()
          ],
        ),
      ),
    );
  }
}
