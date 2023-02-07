class Stock {

  final String symbol;
  final String market;
  final String region;
  final String exchange;

  Stock(this.symbol, this.market, this.region, this.exchange);

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      json['symbol'],
      json['market'],
      json['region'],
      json['exchange'],
    );
  }

}