import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/service/stocks_service.dart';
import 'package:mobile_authnetication_client/widget/stock_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../dto/stock.dart';

class StocksMarketScreen extends StatefulWidget {

  static const routeName = '/stocksMarket';

  const StocksMarketScreen({Key? key}) : super(key: key);

  @override
  State<StocksMarketScreen> createState() => _StocksMarketScreenState();
}

class _StocksMarketScreenState extends State<StocksMarketScreen> {

  late Future<List<Stock>> futureStockList;
  StocksService stocksService = StocksService();

  @override
  void initState() {
    super.initState();
    futureStockList = stocksService.fetchStocks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureStockList,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (dataSnapshot.hasData) {
          List<Stock> stockList = dataSnapshot.requireData;

          return ListView.builder(
            itemCount: stockList.length,
            itemBuilder: (BuildContext listContext, int index) => StockWidget(
              stockList[index].symbol,
              stockList[index].market,
              stockList[index].region,
              stockList[index].exchange,
            )
          );
        } else {
          return Center(child: Text(AppLocalizations.of(context).noData),);
        }
      }
    );
  }
}
