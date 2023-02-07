import 'package:mobile_authnetication_client/dto/stock.dart';

class StockResponse {

  final ResultList quoteResponse;

  StockResponse(this.quoteResponse);

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(json['quoteResponse']);
  }

}

class ResultList {

  final List<Stock> result;

  ResultList(this.result);

  factory ResultList.fromJson(Map<String, dynamic> json) {
    return ResultList(json['result']);
  }

}