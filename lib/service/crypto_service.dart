import 'dart:async';
import 'dart:convert';

import 'package:mobile_authnetication_client/dto/crypto.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class CryptoService {

  Future<List<Crypto>> fetchCrypto() async {
    Map<String, String> headers = {
      Constants.HEADER_KEY: Constants.HEADER_KEY_VALUE,
      Constants.HEADER_HOST: Constants.HEADER_HOST_CRYPTO_VALUE
    };

    final response = await http.get(
        Uri.parse('${Constants.cryptoBaseUrl}/coins?referenceCurrencyUuid=yhjMzLPhuIDl&timePeriod=24h&orderBy=marketCap&orderDirection=desc&limit=10'),
        headers: headers
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> mapper = jsonDecode(response.body);
      if (mapper['status'] == 'success') {
        var tmpList = mapper['data']['coins'] as List;
        List<Crypto> cryptoList = tmpList.map((e) => Crypto.fromJson(e)).toList();

        // return a future
        var completer = Completer<List<Crypto>>();
        completer.complete(cryptoList);
        return completer.future;
      } else {
        throw Exception("failed to get a response");
      }
    } else {
      throw Exception("failed to get a response");
    }
  }
}