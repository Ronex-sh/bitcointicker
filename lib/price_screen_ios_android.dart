import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

//

class PriceScreen3 extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen3> {
  String valueSelectCurrency = 'USD';
  CoinData coinData = CoinData();

  CupertinoPicker getCupertinoButon() {
    List<Text> data = [];
    for (var item in currenciesList) {
      data.add(Text(item));
    }
    return CupertinoPicker(
      itemExtent: 60,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          valueSelectCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: data,
    );
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropdownitem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitem.add(newItem);
    }
    return DropdownButton<String>(
      value: valueSelectCurrency,
      items: dropdownitem,
      onChanged: (var value) {
        setState(() {
          valueSelectCurrency = value;
          getData();
        });

        print(valueSelectCurrency);
      },
    );
  }

  dynamic getDropDownOrCupertino() {
    if (Platform.isIOS) {
      return getCupertinoButon();
    } else if (Platform.isAndroid) {
      return getDropDownButton();
    }
  }

  //value had to be updated into a Map to store the values of all three cryptocurrencies.
  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  void getData() async {
    //7: Second, we set it to true when we initiate the request for prices.
    isWaiting = true;
    try {
      //6: Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await CoinData().getCoinData(valueSelectCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    print('kk1');
    super.initState();
  }

  ////For bonus points, create a method that loops through the cryptoList and generates a CryptoCard for each. Call makeCards() in the build() method instead of the Column with 3 CryptoCards.
//  Column makeCards() {
//    List<CryptoCard> cryptoCards = [];
//    for (String crypto in cryptoList) {
//      cryptoCards.add(
//        CryptoCard(
//          cryptoCurrency: crypto,
//          selectedCurrency: selectedCurrency,
//          value: isWaiting ? '?' : coinValues[crypto],
//        ),
//      );
//    }
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.stretch,
//      children: cryptoCards,
//    );
//  }

  @override
  Widget build(BuildContext context) {
    print('kk2');
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                cryptoCurrency: 'BTC',
                //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
                value: isWaiting ? '?' : coinValues['BTC'],
                selectedCurrency: valueSelectCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting ? '?' : coinValues['ETH'],
                selectedCurrency: valueSelectCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting ? '?' : coinValues['LTC'],
                selectedCurrency: valueSelectCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropDownOrCupertino(),
          ),
        ],
      ),
    );
  }
}

//1: Refactor this Padding Widget into a separate Stateless Widget called CryptoCard, so we can create 3 of them, one for each cryptocurrency.
class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
