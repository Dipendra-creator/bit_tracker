import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

const apiKey = 'FE7E51A1-000B-49ED-B66B-420C1E799B28';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}


class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double bRate = 4565.666;
  double eRate = 4565.666;
  double lRate = 4565.666;
  String url = 'https://rest.coinapi.io/v1/exchangerate';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response1 = await http.get('$url/BTC/$selectedCurrency?apikey=$apiKey');
    http.Response response2 = await http.get('$url/ETH/$selectedCurrency?apikey=$apiKey');
    http.Response response3 = await http.get('$url/LTC/$selectedCurrency?apikey=$apiKey');

    var decodedData1 = jsonDecode(response1.body);
    var decodedData2 = jsonDecode(response2.body);
    var decodedData3 = jsonDecode(response3.body);

    double bPrice = decodedData1['rate'];
    double ePrice = decodedData2['rate'];
    double lPrice = decodedData3['rate'];
    setState(() {
      bRate = bPrice;
      eRate = ePrice;
      lRate = lPrice;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('\n\n$url/BTC/$selectedCurrency?apikey=$apiKey\n\n');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[0]} = ${bRate.toInt()} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[1]} = ${eRate.toInt()} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${cryptoList[2]} = ${lRate.toInt()} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() :  androidDropdown(),
          ),
        ],
      ),
    );
  }
}

