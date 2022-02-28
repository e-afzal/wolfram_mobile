// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:wolfram/model/search.dart';

// THIRD PARTY PACKAGES
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();

  final sendFilteredResult;
  final searchTerm;
  final sortBy;
  FilterScreen({this.sendFilteredResult, this.searchTerm, this.sortBy});
}

class _FilterScreenState extends State<FilterScreen> {
  var fToast;
  String type = 'all';
  double minPrice = 0;
  double maxPrice = 50000000;
  int minBed = 1;
  int maxBed = 7;
  String toastMessage = '';

  // REQUIRED: For min. & max. price 'slider'
  SfRangeValues minMaxPrice = SfRangeValues(0.0, 50000000.0);

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
            toastMessage,
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

  void selectedMinBed(index) {
    if (index == 0) {
      setState(() {
        minBed = 1;
      });
    } else if (index == 1) {
      setState(() {
        minBed = 2;
      });
    } else if (index == 2) {
      setState(() {
        minBed = 3;
      });
    } else if (index == 3) {
      setState(() {
        minBed = 4;
      });
    } else if (index == 4) {
      setState(() {
        minBed = 5;
      });
    } else if (index == 5) {
      setState(() {
        minBed = 6;
      });
    } else if (index == 6) {
      setState(() {
        minBed = 7;
      });
    }
  }

  void selectedMaxBed(index) {
    if (index == 0) {
      setState(() {
        maxBed = 1;
      });
    } else if (index == 1) {
      setState(() {
        maxBed = 2;
      });
    } else if (index == 2) {
      setState(() {
        maxBed = 3;
      });
    } else if (index == 3) {
      setState(() {
        maxBed = 4;
      });
    } else if (index == 4) {
      setState(() {
        maxBed = 5;
      });
    } else if (index == 5) {
      setState(() {
        maxBed = 6;
      });
    } else if (index == 6) {
      setState(() {
        maxBed = 7;
      });
    }
  }

  void fetchFilteredResults() async {
    List filteredResult = await Search().fetchData(
        category: type,
        searchTerm: widget.searchTerm == null ? '' : widget.searchTerm,
        minPrice: minPrice.toInt(),
        maxPrice: maxPrice.toInt(),
        minBed: minBed,
        maxBed: maxBed);

    // Sort results before sending based on 'SearchResultsScreen'
    if (widget.sortBy == 'PriceH2L') {
      // Sort 'price' in 'DESCENDING' ORDER
      filteredResult.sort((b, a) => a['price'].compareTo(b['price']));
    } else if (widget.sortBy == 'PriceL2H') {
      // Sort 'price' in 'ASCENDING' ORDER
      filteredResult.sort((a, b) => a['price'].compareTo(b['price']));
    }

    widget.sendFilteredResult(filteredResult);
  }

  void filterHandler() async {
    if (minBed > maxBed) {
      setState(() {
        toastMessage = 'Min. Bed must be less than Max. Bed';
      });
      showToast();
      return;
    } else {
      fetchFilteredResults();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 'INTL' currency formatter 'instance'
    var numberFormat = NumberFormat();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(title: Text('Filters'), backgroundColor: Color(0xff31343a)),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // CATEGORY: PROPERTY TYPE
                Row(
                  children: [
                    Icon(Icons.business_sharp, color: Color(0xff31343a)),
                    SizedBox(width: 10),
                    Text('Property Type',
                        style: TextStyle(
                            color: Color(0xff31343a),
                            fontFamily: 'ANC-Medium',
                            fontSize: 18)),
                  ],
                ),
                DropdownButton<String>(
                  value: type,
                  style: TextStyle(
                      color: Color(0xff31343a),
                      fontSize: 16,
                      fontFamily: 'ANC-Medium'),
                  dropdownColor: Color(0xfff2f2f2),
                  onChanged: (String? newValue) {
                    setState(() {
                      type = newValue!;
                    });
                  },
                  items: <String>['all', 'apartment', 'villa']
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),
                ),

                SizedBox(height: 25),

                // CATEGORY: PRICE
                Row(
                  children: [
                    Icon(Icons.attach_money_sharp, color: Color(0xff31343a)),
                    SizedBox(width: 10),
                    Text('Price',
                        style: TextStyle(
                            color: Color(0xff31343a),
                            fontFamily: 'ANC-Medium',
                            fontSize: 18)),
                  ],
                ),

                Container(
                  width: double.infinity,
                  child: SfRangeSlider(
                      activeColor: Color(0xff31343a),
                      min: 0.0,
                      max: 50000000.0,
                      values: minMaxPrice,
                      interval: 2000000,
                      showTicks: true,
                      showLabels: false,
                      enableTooltip: true,
                      tooltipTextFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        return numberFormat.format(actualValue);
                      },
                      stepSize: 2000000,
                      onChanged: (SfRangeValues values) {
                        setState(() {
                          minMaxPrice = values;
                          minPrice = minMaxPrice.start;
                          maxPrice = minMaxPrice.end;
                        });
                      }),
                ),

                SizedBox(height: 25),

                // CATEGORY: BEDROOMS
                Row(
                  children: [
                    Icon(Icons.bed_sharp, color: Color(0xff31343a)),
                    SizedBox(width: 10),
                    Text('Bedrooms',
                        style: TextStyle(
                            color: Color(0xff31343a),
                            fontFamily: 'ANC-Medium',
                            fontSize: 18)),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Min. Bedrooms
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Min. BD: $minBed ${minBed > 1 ? 'bedrooms' : 'bedroom'}',
                              style: TextStyle(
                                  color: Color(0xff31343a),
                                  fontFamily: 'ANC-Medium',
                                  fontSize: 16)),
                          SizedBox(height: 5),
                          GroupButton(
                            groupingType: GroupingType.column,
                            mainGroupAlignment: MainGroupAlignment.start,
                            spacing: 0,
                            isRadio: true,
                            selectedColor: Colors.black,
                            selectedTextStyle: TextStyle(color: Colors.white),
                            borderRadius: BorderRadius.circular(6),
                            unselectedColor: Colors.transparent,
                            unselectedTextStyle: TextStyle(color: Colors.black),
                            unselectedBorderColor: Colors.black,
                            buttons: [
                              '1 BD',
                              '2 BD',
                              '3 BD',
                              '4 BD',
                              '5 BD',
                              '6 BD',
                              '7 BD'
                            ],
                            onSelected: (index, isSelected) =>
                                selectedMinBed(index),
                            selectedButton: 0,
                          ),
                        ],
                      ),
                    ),

                    // Max. Bedrooms
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Max. BD: $maxBed ${maxBed > 1 ? 'bedrooms' : 'bedroom'}',
                              style: TextStyle(
                                  color: Color(0xff31343a),
                                  fontFamily: 'ANC-Medium',
                                  fontSize: 16)),
                          SizedBox(height: 5),
                          GroupButton(
                            groupingType: GroupingType.column,
                            mainGroupAlignment: MainGroupAlignment.start,
                            isRadio: true,
                            spacing: 0,
                            selectedColor: Colors.black,
                            selectedTextStyle: TextStyle(color: Colors.white),
                            borderRadius: BorderRadius.circular(6),
                            unselectedColor: Colors.transparent,
                            unselectedTextStyle: TextStyle(color: Colors.black),
                            unselectedBorderColor: Colors.black,
                            buttons: [
                              '1 BD',
                              '2 BD',
                              '3 BD',
                              '4 BD',
                              '5 BD',
                              '6 BD',
                              '7 BD'
                            ],
                            onSelected: (index, isSelected) =>
                                {selectedMaxBed(index)},
                            selectedButton: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                // BUTTON
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    autofocus: false,
                    clipBehavior: Clip.none,
                    onPressed: () {
                      print('SHOW PROPS BUTTON PRESSED');
                      filterHandler();
                    },
                    child: Text(
                      "SET FILTERS",
                      style: TextStyle(
                          fontFamily: 'FiraSans-Medium',
                          fontSize: 18.0,
                          letterSpacing: 0.5),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
