import 'package:flutter/material.dart';

import '../config.dart';
import 'network_helper.dart';

class CoinApi {
  Future<dynamic> getCoinData(String coin, String currency) async {
    Uri uri = Uri.https('rest.coinapi.io', '/v1/exchangerate/$coin/$currency', {
      'apikey': apiKey,
    });
    print('uri : $uri');

    NetworkHelper networkHelper = NetworkHelper(uri);

    print('networkHelper : $networkHelper.toString()');

    var coinData = await networkHelper.getData();

    return coinData;
  }
}
