import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StockWidget extends StatelessWidget {

  final String symbol;
  final String market;
  final String region;
  final String exchange;

  const StockWidget(this.symbol, this.market, this.region, this.exchange, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Text(symbol),
          title: Text(exchange),
          subtitle: Text(market),
        ),
      ),
    );
  }
}
