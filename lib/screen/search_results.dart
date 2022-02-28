// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wolfram/model/search.dart';
import 'package:wolfram/screen/filterScreen.dart';
import 'package:wolfram/screen/single_property.dart';
import 'package:wolfram/components/searchbarSecondary.dart';
import 'package:wolfram/components/bottom_sheet.dart';
import 'package:wolfram/components/footer.dart';

// THIRD PARTY PACKAGES
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();

  final query;
  SearchResults({this.query});
}

class _SearchResultsState extends State<SearchResults> {
  var sortByValue = "PriceH2L";
  var keyword = '';
  var minPrice = 0;
  var maxPrice = 100000000;
  var minBed = 1;
  var maxBed = 10;
  var category = 'all';
  var result = [];

  dynamic getData() async {
    var data = await Provider.of<Search>(context, listen: false).fetchData(
        searchTerm: keyword,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minBed: minBed,
        maxBed: maxBed,
        category: category);

    // 'container' takes the 'data'
    var container = [];
    setState(() {
      container = data;
    });

    // 1st, sort (desc. order) 'container' on 'price' basis
    container.sort((b, a) => a['price'].compareTo(b['price']));
    // 'result' is finally displayed on UI with price in 'desc. order'.
    setState(() {
      result = container;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      keyword = widget.query == null ? '' : widget.query;
    });
    getData();
  }

  // Single Property Tile Template
  dynamic singleProperty(
      {image, category, price, name, area, city, propertyData}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: () {
          // Navigate to Single Property Details screen
          var route = MaterialPageRoute(
              builder: (context) => SingleProperty(propertyData: propertyData));
          Navigator.push(context, route);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Image.network(image[0], fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: Text(
                      category.toUpperCase(),
                      style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'ANC-Medium',
                          fontSize: 15,
                          color: Color(0xffae989c)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                    child: Text(
                      'AED $price',
                      style: TextStyle(
                          fontFamily: 'ANC-Regular',
                          fontSize: 20,
                          color: Color(0xff31343a)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '$name, $area, $city',
                      style: TextStyle(
                          fontFamily: 'ANC-Regular',
                          fontSize: 15,
                          color: Color(0xff31343a),
                          height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic receiveFilteredResult(filteredResult) {
    setState(() {
      result = filteredResult;
    });
  }

// SORT HANDLER
  void getSortBy(value) {
    var container = [];
    setState(() {
      sortByValue = value;
      container = result;
    });
    if (sortByValue == 'PriceH2L') {
      // Sort 'price' in 'DESCENDING' ORDER
      container.sort((b, a) => a['price'].compareTo(b['price']));
      setState(() {
        result = container;
      });
    } else if (sortByValue == 'PriceL2H') {
      // Sort 'price' in 'ASCENDING' ORDER
      container.sort((a, b) => a['price'].compareTo(b['price']));
      setState(() {
        result = container;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 'INTL' price formatter 'instance'
    var numberFormat = NumberFormat();
    // Calculation: Loader Padding Top Height
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double appBarHeight = AppBar().preferredSize.height;
    double bodyHeight = MediaQuery.of(context).size.height;
    double finalPadding = bodyHeight - (statusbarHeight + appBarHeight);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navbar(bgdColor: Colors.black),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SEARCHBAR
                  SearchbarSecondary(),

                  SizedBox(
                    height: 20,
                  ),

                  // 'FILTER' & 'SORT' row
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    InkWell(
                      onTap: () async {
                        print("FILTER TAPPED");
                        // When Filter used, filters from 'FilterScreen' saved to 'filterResult'
                        var route = MaterialPageRoute(
                            builder: (context) => FilterScreen(
                                sendFilteredResult: receiveFilteredResult,
                                searchTerm: widget.query,
                                sortBy: sortByValue));
                        Navigator.push(context, route);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.filter_alt_sharp,
                              color: Color(0xff31343a),
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text('Filter',
                                style: TextStyle(
                                    color: Color(0xff31343a),
                                    fontFamily: 'ANC-Medium',
                                    fontSize: 17)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("SORT TAPPED");
                        showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                SortBottomSheet(sendSort: getSortBy));
                      },
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_list_sharp,
                              color: Color(0xff31343a),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                                'Price ${sortByValue == "PriceH2L" ? "(Highest to Lowest)" : "(Lowest to Highest)"}',
                                style: TextStyle(
                                    color: Color(0xff31343a),
                                    fontFamily: 'ANC-Medium',
                                    fontSize: 17)),
                          ],
                        ),
                      ),
                    ),
                  ]),

                  Divider(
                    thickness: .6,
                    height: 30,
                    color: Color(0xff31343a),
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: result.length == 0
                          ? [
                              Center(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 80),
                                    child: SpinKitFadingCube(
                                      color: Color(0xff31343a),
                                      size: 40,
                                    )),
                              )
                            ]
                          : [
                              Text(
                                '${result.length} ${result.length > 1 ? 'properties' : 'property'} found',
                                style: TextStyle(
                                    fontFamily: 'ANC-Regular',
                                    color: Color(0xff31343a),
                                    fontSize: 21),
                              ),

                              SizedBox(height: 20),

                              // Search Results
                              for (var eachItem in result)
                                singleProperty(
                                    image: eachItem['image'],
                                    category: eachItem['category'],
                                    price:
                                        numberFormat.format(eachItem['price']),
                                    name: eachItem['name'],
                                    area: eachItem['area'],
                                    city: eachItem['city'],
                                    propertyData: eachItem)
                            ]),
                ],
              ),
            ),
          ),
          Footer(marginTop: result.length == 1 ? 45.0 : 0.0),
        ],
      )),
    );
  }
}
