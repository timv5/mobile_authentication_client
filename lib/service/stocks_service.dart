import 'dart:async';
import 'dart:convert';

import 'package:mobile_authnetication_client/constants/constants.dart';
import 'package:mobile_authnetication_client/dto/stock.dart';
import 'package:http/http.dart' as http;

class StocksService {

  Future<List<Stock>> fetchStocks() async {
    List<Stock> stockResponse = [];

    Map<String, String> headers = {
      Constants.HEADER_KEY: Constants.HEADER_KEY_VALUE,
      Constants.HEADER_HOST: Constants.HEADER_HOST_VALUE
    };
    for (String symbol in Constants.stockList) {
      final response = await http.get(
          Uri.parse('${Constants.stockBaseUrl}/v7/finance/quote?symbols=$symbol'),
          headers: headers
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = jsonDecode(response.body);
        if (userMap['quoteResponse']['error'] != null) {
          throw Exception("failed to get a response");
        }

        stockResponse.add(Stock.fromJson(userMap['quoteResponse']['result'][0]));
      } else {
        throw Exception("failed to get a response");
      }
    }

    // return a future
    var completer = Completer<List<Stock>>();
    completer.complete(stockResponse);
    return completer.future;
  }

}