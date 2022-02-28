// LOCAL PACKAGES
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:wolfram/global.dart';

// THIRD PARTY PACKAGE
import 'package:http/http.dart';

class Search extends ChangeNotifier {
  var _result;

  Future fetchData(
      {searchTerm, minPrice, maxPrice, minBed, maxBed, category}) async {
    Map body = {
      'keyword': searchTerm,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'minBed': minBed,
      'maxBed': maxBed,
      'category': category
    };

    // Convert body to JSON
    var encodedBody = jsonEncode(body);

    // Post 'Header'
    Map<String, String> postHeader = {'Content-Type': 'application/json'};

    var response = await post(Uri.parse('$baseUrl/api/properties/search'),
        body: encodedBody, headers: postHeader);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      _result = responseData;
      print('MODEL RESULT: ${_result.length}');
      notifyListeners();
      return _result;
    } else {
      print(
          'ERROR - Status Code: ${response.statusCode} - Unable to fetch data');
    }
  }
}
