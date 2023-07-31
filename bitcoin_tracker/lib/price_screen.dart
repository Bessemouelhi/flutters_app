import 'package:bitcoin_tracker/service/coin_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var coinData;
  List<int> priceValues = [];
  CoinApi coinApi = CoinApi();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < cryptoList.length; i++) {
      priceValues.add(0);
    }
  }

  updateUI(var data, index) async {
    double temp = data['rate'];
    priceValues[index] = temp.toInt();
    print(data);
    print(priceValues[index]);
  }

  Future<void> updateAllCurrency(value) async {
    for (int i = 0; i < cryptoList.length; i++) {
      coinData = await coinApi.getCoinData(cryptoList[i], value!);
      setState(() {
        dropdownValue = value!;
        updateUI(coinData, i);
      });
    }
  }

  String dropdownValue = currenciesList.first;

  //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=42530753-8982-43F2-887D-17192C29CCB4

  List<DropdownMenuItem<String>> getDropdownItems() {
    return currenciesList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle_outlined),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? value) {
// This is called when the user selects an item. n
        updateAllCurrency(value);
      },
      items: getDropdownItems(),
    );
  }

  /////////////////// IOS /////////////////////////////////
  List<Widget> getPickerItems() {
    List<Widget> listText = [];
    for (String currency in currenciesList) {
      listText.add(Text(currency));
    }

    return listText;
  }

  List<Widget> getListCurrencyItems() {
    List<Widget> listItems = [];
    for (final (index, currency) in cryptoList.indexed) {
      listItems.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $currency = ${priceValues[index]} $dropdownValue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    return listItems;
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {},
      children: getPickerItems(),
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Tracker'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.currency_bitcoin,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(children: getListCurrencyItems()),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          )
        ],
      ),
    );
  }
}

// Container(
// height: 150.0,
// alignment: Alignment.center,
// padding: EdgeInsets.only(bottom: 30.0),
// color: Colors.lightBlue,
// child: DropdownButton<String>(
// value: dropdownValue,
// icon: const Icon(Icons.arrow_drop_down_circle_outlined),
// elevation: 16,
// style: const TextStyle(color: Colors.white),
// underline: Container(
// height: 2,
// color: Colors.white,
// ),
// onChanged: (String? value) {
// // This is called when the user selects an item.
// setState(() {
// dropdownValue = value!;
// });
// },
// items:
// currenciesList.map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// ),
// ),
