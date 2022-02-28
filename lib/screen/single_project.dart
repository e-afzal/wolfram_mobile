// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wolfram/global.dart';
import 'package:wolfram/components/footer.dart';
import 'package:wolfram/components/imageSlider.dart';
import 'package:wolfram/components/google_map.dart';

// THIRD PARTY PACKAGES
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SingleProject extends StatefulWidget {
  @override
  _SingleProjectState createState() => _SingleProjectState();

  final projectId;
  SingleProject({this.projectId});
}

class _SingleProjectState extends State<SingleProject> {
  Map projectData = {};

  dynamic fetchData() async {
    var response =
        await get(Uri.parse('$baseUrl/api/projects/${widget.projectId}'));
    setState(() {
      projectData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // Calculation: Loader Padding Top Height
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    double bodyHeight = MediaQuery.of(context).size.height;
    double finalPadding = bodyHeight - (statusbarHeight + appBarHeight);

    var empty = projectData.isEmpty;
    var images = empty ? [] : projectData['carouselImg'];
    String name = empty ? '' : projectData['name'];
    String developer = empty ? '' : projectData['developer'];
    String price = empty ? '' : projectData['price'];
    String pricePerSqFt = empty ? '' : projectData['pricePerSqFt'];
    String bedrooms = empty ? '' : projectData['bedrooms'];
    int units = empty ? 0 : projectData['units'];
    String status = empty ? '' : projectData['status'];
    String deliveryDate = empty ? '' : projectData['deliveryDate'];
    String description = empty ? '' : projectData['description'];
    List splitDescription = description.split('|');
    Map<String, dynamic> map = empty ? {} : projectData['map'];
    int planBooking = empty ? 0 : projectData['planBooking'];
    int planHandover = empty ? 0 : projectData['planHandover'];
    int planComplete = empty ? 0 : projectData['planComplete'];

    Widget eachDetail({detailType, detailNumber}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.check, color: Color(0xff31343a), size: 17),
          ),
          Text('$detailType: $detailNumber',
              style: TextStyle(
                  fontFamily: 'ANC-Regular', fontSize: 16, color: Colors.black))
        ]),
      );
    }

    // 'INTL' currency formatter 'instance'
    var numberFormat = NumberFormat();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            name,
            style: TextStyle(fontFamily: 'ANC-Medium'),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: projectData.isEmpty
            ? [
                SafeArea(
                    child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: finalPadding * 0.40),
                      child: SpinKitFadingCube(
                        color: Colors.black,
                        size: 40,
                      )),
                ))
              ]
            : [
                // IMAGE GALLERY
                ImageSlider(images),

                // Row-based details
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('apartment for sale'.toUpperCase(),
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontFamily: 'ANC-Medium',
                                    fontSize: 18,
                                    color: Color(0xffae989c))),
                            SizedBox(height: 7),
                            Text('$name by $developer',
                                style: TextStyle(
                                    fontFamily: 'ANC-Regular',
                                    fontSize: 16,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$price',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'ANC-Regular',
                              fontSize: 20,
                              color: Color(0xff31343a)),
                        ),
                      )
                    ],
                  ),
                ),

                // SECTION: Details at a glance
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DETAILS AT A GLANCE',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: 'ANC-Medium',
                                  fontSize: 18,
                                  color: Color(0xffae989c))),
                          SizedBox(height: 7),
                          eachDetail(
                              detailType: 'Starting price',
                              detailNumber: price),
                          eachDetail(
                              detailType: 'Price per sq. ft',
                              detailNumber: pricePerSqFt),
                          eachDetail(
                              detailType: 'Bedrooms', detailNumber: bedrooms),
                          eachDetail(
                              detailType: 'Total units',
                              detailNumber: numberFormat.format(units)),
                          eachDetail(
                              detailType: 'Completion status',
                              detailNumber: status),
                          eachDetail(
                              detailType: 'Delivery date',
                              detailNumber: deliveryDate),
                        ])),

                // SECTION: Description
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DESCRIPTION',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: 'ANC-Medium',
                                  fontSize: 18,
                                  color: Color(0xffae989c))),
                          SizedBox(height: 7),
                          Column(
                            children: splitDescription
                                .map((eachPara) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(eachPara,
                                          style: TextStyle(
                                              fontFamily: 'ANC-Regular',
                                              fontSize: 16,
                                              height: 1.5,
                                              color: Colors.black)),
                                    ))
                                .toList(),
                          )
                        ])),

                // SECTION: Location Map
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOCATION MAP',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: 'ANC-Medium',
                                  fontSize: 18,
                                  color: Color(0xffae989c))),
                          SizedBox(height: 7),
                          PropertiesMap(lat: map['lat'], long: map['long']),
                        ])),

                // SECTION: Payment Plan
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PAYMENT PLAN',
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: 'ANC-Medium',
                              fontSize: 18,
                              color: Color(0xffae989c))),
                      SizedBox(height: 13),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Planned Booking
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$planBooking%',
                                      style: TextStyle(
                                          fontFamily: 'ANC-Regular',
                                          fontSize: 20,
                                          color: Color(0xff31343a))),
                                  Text('on booking',
                                      style: TextStyle(
                                          fontFamily: 'ANC-Regular',
                                          fontSize: 14.5,
                                          color: Colors.black54)),
                                ],
                              ),
                            ),

                            // Planned handover
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$planHandover%',
                                      style: TextStyle(
                                          fontFamily: 'ANC-Regular',
                                          fontSize: 20,
                                          color: Color(0xff31343a))),
                                  Text('on handover',
                                      style: TextStyle(
                                          fontFamily: 'ANC-Regular',
                                          fontSize: 14.5,
                                          color: Colors.black54)),
                                ],
                              ),
                            ),

                            // Completion status
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$planComplete%',
                                    style: TextStyle(
                                        fontFamily: 'ANC-Regular',
                                        fontSize: 20,
                                        color: Color(0xff31343a))),
                                Text('construction complete',
                                    style: TextStyle(
                                        fontFamily: 'ANC-Regular',
                                        fontSize: 14.5,
                                        color: Colors.black54)),
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),

                // COMPONENT: Footer
                Footer()
              ],
      )),
    );
  }
}
