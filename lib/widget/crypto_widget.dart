import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CryptoWidget extends StatelessWidget {

  final String symbol;
  final String name;
  final String marketCap;
  final String price;
  final String iconUrl;
  final int rank;

  const CryptoWidget(this.symbol, this.name, this.marketCap, this.price, this.iconUrl,
      this.rank, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Text(name),
          title: Text(symbol),
          subtitle: Text(price)
        ),
      ),
    );
  }
}
