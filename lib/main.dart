// LOCAL PACKAGES
import 'package:flutter/material.dart';
import 'package:wolfram/model/search.dart';

// THIRD PARTY PACKAGES
import 'package:provider/provider.dart';

// SCREENS
import 'package:wolfram/screen/home.dart';
import 'package:wolfram/screen/single_property.dart';
import 'package:wolfram/screen/single_project.dart';
import 'package:wolfram/screen/search_results.dart';
import 'package:wolfram/screen/filterScreen.dart';
import 'package:wolfram/screen/contact.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Search())],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/singleProperty': (context) => SingleProperty(),
        '/singleProject': (context) => SingleProject(),
        '/results': (context) => SearchResults(),
        '/filter': (context) => FilterScreen(),
        '/contact':(context)=>Contact()
      },
    ),
  ));
}
