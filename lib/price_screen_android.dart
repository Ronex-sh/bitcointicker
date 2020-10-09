import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String valueSelectCurrency = 'USD';

  //First solution
//  List<DropdownMenuItem> getDropDownItems() {
//    List<DropdownMenuItem<String>> dropdownitem = [];
//    for (int i = 0; i < currenciesList.length; i++) {
//      String currency = currenciesList[i];
//      var newItem = DropdownMenuItem(
//        child: Text(currency),
//        value: currency,
//      );
//      dropdownitem.add(newItem);
//    }
//    return dropdownitem;
//  }
  //second solution
  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropdownitem = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitem.add(newItem);
    }
    return dropdownitem;
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: valueSelectCurrency,
              items: getDropDownItems(),
              //[

//                DropdownMenuItem(
//                  child: Text('l'),
//                  value: 'US',
//                ),
//                DropdownMenuItem(
//                  child: Text('lll'),
//                  value: 'U',
//                ),
              //],
              onChanged: (var value) {
                setState(() {
                  valueSelectCurrency = value;
                });
                print(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
