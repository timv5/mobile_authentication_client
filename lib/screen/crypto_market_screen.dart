import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/service/crypto_service.dart';
import 'package:mobile_authnetication_client/dto/crypto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_authnetication_client/widget/crypto_widget.dart';

class CryptoMarketScreen extends StatefulWidget {

  static const routeName = '/cryptoMarket';

  const CryptoMarketScreen({Key? key}) : super(key: key);

  @override
  State<CryptoMarketScreen> createState() => _CryptoMarketScreenState();

}

class _CryptoMarketScreenState extends State<CryptoMarketScreen> {

  late Future<List<Crypto>> futureCryptoList;
  CryptoService cryptoService = CryptoService();

  @override
  void initState() {
    super.initState();
    futureCryptoList = cryptoService.fetchCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCryptoList,
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (dataSnapshot.hasData) {
          List<Crypto> cryptoList = dataSnapshot.requireData;

          return ListView.builder(
            itemCount: cryptoList.length,
            itemBuilder: (BuildContext cryptoContext, int index) => CryptoWidget(
              cryptoList[index].symbol,
              cryptoList[index].name,
              cryptoList[index].marketCap,
              cryptoList[index].price,
              cryptoList[index].iconUrl,
              cryptoList[index].rank
            )
          );
        } else {
          return Text(AppLocalizations.of(context).noData);
        }
      }
    );
  }
}
