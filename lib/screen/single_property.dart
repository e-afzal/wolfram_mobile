// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:wolfram/components/footer.dart';
import 'package:wolfram/components/imageSlider.dart';
import 'package:wolfram/components/google_map.dart';

// THIRD PARTY PACKAGE
import 'package:intl/intl.dart';

class SingleProperty extends StatefulWidget {
  @override
  _SinglePropertyState createState() => _SinglePropertyState();

  final propertyData;
  SingleProperty({this.propertyData});
}

class _SinglePropertyState extends State<SingleProperty> {
  @override
  Widget build(BuildContext context) {
    dynamic images = widget.propertyData['image'];
    String category = widget.propertyData['category'];
    String name = widget.propertyData['name'];
    String area = widget.propertyData['area'];
    String city = widget.propertyData['city'];
    int price = widget.propertyData['price'];
    int bedrooms = widget.propertyData['bedrooms'];
    int bathrooms = widget.propertyData['bathrooms'];
    int buildUp = widget.propertyData['buildUp'];
    int refNo = widget.propertyData['refNo'];
    String description = widget.propertyData['description'];
    List splitDescription = description.split('|');
    Map<String, dynamic> map = widget.propertyData['map'];
    dynamic agentDetails = widget.propertyData['agent'];

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
          backgroundColor: Colors.black, title: Text(name,style: TextStyle(fontFamily: 'ANC-Medium'),), centerTitle: true),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      Text('$category for sale'.toUpperCase(),
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: 'ANC-Medium',
                              fontSize: 18,
                              color: Color(0xffae989c))),
                      SizedBox(height: 7),
                      Text('$name, $area, $city',
                          style: TextStyle(
                              fontFamily: 'ANC-Regular',
                              fontSize: 16,
                              color: Colors.black))
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    'AED ${numberFormat.format(price)}',
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
                        detailType: 'Property Type',
                        detailNumber: toBeginningOfSentenceCase(category)),
                    eachDetail(detailType: 'Bedrooms', detailNumber: bedrooms),
                    eachDetail(
                        detailType: 'Bathrooms', detailNumber: bathrooms),
                    eachDetail(
                        detailType: 'Property Size', detailNumber: buildUp),
                    eachDetail(
                        detailType: 'Reference Number', detailNumber: refNo),
                  ])),

          // SECTION: Description
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                                padding: const EdgeInsets.only(bottom: 10),
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

          // SECTION: Agent Details
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 20),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AGENT DETAILS',
                            style: TextStyle(
                                letterSpacing: 1,
                                fontFamily: 'ANC-Medium',
                                fontSize: 18,
                                color: Color(0xffae989c))),
                        SizedBox(height: 7),
                        Text('${agentDetails['name']}',
                            style: TextStyle(
                                fontFamily: 'ANC-Regular',
                                fontSize: 16,
                                color: Color(0xff31343a))),
                        Text('${agentDetails['position']}',
                            style: TextStyle(
                                fontFamily: 'ANC-Regular',
                                fontSize: 16,
                                color: Colors.black54)),
                      ],
                    ),
                  ),
                  // AGENT IMAGE
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                      child: Image.network(agentDetails['image'],
                          height: 150, fit: BoxFit.cover),
                    ),
                  )
                ]),
          ),

          // BUTTONS: Agent-related
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // BUTTON 1
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        child: ElevatedButton(
                          autofocus: false,
                          clipBehavior: Clip.none,
                          onPressed: () {
                            print('CALL NOW tapped');
                          },
                          child: Text(
                            "CALL NOW",
                            style: TextStyle(
                                fontFamily: 'ANC-Medium',
                                fontSize: 18.0,
                                letterSpacing: 1),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff31343a))),
                        ),
                      ),
                    ),
                  ),

                  // Seperator between buttons
                  SizedBox(width: 25),

                  // BUTTON 2
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        child: ElevatedButton(
                          autofocus: false,
                          clipBehavior: Clip.none,
                          onPressed: () {
                            print('SEND EMAIL tapped');
                          },
                          child: Text(
                            "SEND EMAIL",
                            style: TextStyle(
                                fontFamily: 'ANC-Medium',
                                fontSize: 18.0,
                                letterSpacing: 1),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff31343a))),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),

          // COMPONENT: Footer
          Footer()
        ],
      )),
    );
  }
}
