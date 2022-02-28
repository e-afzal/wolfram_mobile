// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:wolfram/global.dart';
import 'package:wolfram/components/footer.dart';
import 'package:wolfram/components/navbar.dart';
import 'package:wolfram/components/searchbar.dart';
import 'package:wolfram/components/side_drawer.dart';
import 'package:wolfram/screen/single_project.dart';
import 'package:wolfram/screen/single_property.dart';

// Third Party Packages
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List propertiesList = [];

  // Fetch property data
  void fetchData() async {
    var response = await get(Uri.parse('$baseUrl/api/properties'));
    setState(() {
      propertiesList = jsonDecode(response.body).sublist(0, 5);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

// Single Property Tile Template
  Widget singleProperty(
      {category, price, name, area, city, propertyData, image}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
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
                      category,
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

// Single Project Tile Template
  dynamic singleProject({image, name, area, city, id}) {
    return GestureDetector(
      onTap: () {
        // Route to project
        var route = MaterialPageRoute(
            builder: (context) => SingleProject(projectId: id));
        Navigator.push(context, route);
      },
      child: Container(
        width: 200,
        height: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                height: 105,
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                  color: Color(0xff31343a),
                  fontFamily: 'ANC-Regular',
                  fontSize: 18),
            ),
            SizedBox(height: 1),
            Text(
              '$area, $city',
              style: TextStyle(
                  color: Color(0xff7e7e79),
                  fontFamily: 'ANC-Regular',
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 'INTL' price formatter 'instance'
    var numberFormat = NumberFormat();

    return Scaffold(
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION: HERO
            Container(
              height: 370,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/home/teal-sky.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Column(children: [
                Navbar(bgdColor: Colors.transparent),
                SizedBox(height: 65),
                Text(
                  'BEGIN YOUR SEARCH',
                  style: TextStyle(
                      letterSpacing: .85,
                      fontFamily: 'ANC-Medium',
                      fontSize: 25,
                      color: Colors.white),
                ),

                SizedBox(height: 20),

                // COMPONENT: Searchbar
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Searchbar(),
                ),
                SizedBox(height: 65),
              ]),
            ),

            //  SECTION: LATEST LISTINGS
            SizedBox(height: 35),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Latest Listings',
                style: TextStyle(
                    fontFamily: 'ANC-Bold',
                    color: Color(0xff31343a),
                    fontSize: 25),
              ),
            ),

            // LISTINGS GRID
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
              child: Column(
                  children: propertiesList.length == 0
                      ? [Center(child: Text(''))]
                      : propertiesList
                          .map((eachListing) => singleProperty(
                              category: eachListing['category'].toUpperCase(),
                              price: numberFormat.format(eachListing['price']),
                              name: eachListing['name'],
                              area: eachListing['area'],
                              city: eachListing['city'],
                              propertyData: eachListing,
                              image: eachListing['image'][0]))
                          .toList()),
            ),

            // SECTION: FEATURED DEVELOPMENTS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Featured Developments',
                style: TextStyle(
                    fontFamily: 'ANC-Bold',
                    color: Color(0xff31343a),
                    fontSize: 25),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            // Horizontal Developments
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                  height: 180,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    children: [
                      singleProject(
                          image: 'assets/image/projects/Ghadeer/1.jpg',
                          name: 'Al Ghadeer',
                          area: 'Al Ghadeer',
                          city: 'Abu Dhabi',
                          id: '602985d65e979d15dcd54e77'),
                      singleProject(
                          image: 'assets/image/projects/Muraba/1.jpg',
                          name: 'Muraba Residences',
                          area: 'Palm Jumeirah',
                          city: 'Dubai',
                          id: '602985d65e979d15dcd54e78'),
                      singleProject(
                          image: 'assets/image/projects/Grand_Views/1.jpg',
                          name: 'Grand Views',
                          area: 'Millenium Estates',
                          city: 'Dubai',
                          id: '602985d65e979d15dcd54e79'),
                    ],
                  )),
            ),

            // COMPONENT: FOOTER
            Footer(),
          ],
        ),
      ),
    );
  }
}
