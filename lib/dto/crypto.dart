class Crypto {

  final String symbol;
  final String name;
  final String marketCap;
  final String price;
  final String iconUrl;
  final int rank;

  Crypto(this.symbol, this.name, this.marketCap, this.price, this.iconUrl, this.rank);

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      json['symbol'],
      json['name'],
      json['marketCap'],
      json['price'],
      json['iconUrl'],
      json['rank']
    );
  }

}