//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:money/money.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'networking.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(GasCalc());

class GasCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21), // 0xFF0A0E21
        scaffoldBackgroundColor: Colors.black54, // 0xFF0A0E21
      ),
      home: Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.black54,
//          elevation: 0,
//          title: Center(
//            child: AutoSizeText(
//              'SNAP GAS',
//              style: TextStyle(
//                fontSize: 70.0,
//                fontWeight: FontWeight.w900,
//              ),
//              maxLines: 1,
//              maxFontSize: 45,
//            ),
//          ),
//        ),
        body: Gassy(),
      ),
    );
  }
}

class Gassy extends StatefulWidget {



  @override
  _GassyState createState() => _GassyState();
}

class _GassyState extends State<Gassy> {
  dynamic money = Money(250, Currency('USD'));
  dynamic moneyMathBig = Money(10,
      Currency('USD')); // I can remove the USD if it doesn't look nice later???
  dynamic moneyMathSmall = Money(1, Currency('USD'));
  dynamic moneyMathMax = Money(999, Currency('USD'));
  dynamic moneyMathMin = Money(50, Currency('USD'));
  dynamic moneyMathTB = Money(990, Currency('USD'));
  dynamic moneyMathTS = Money(999, Currency('USD'));
  dynamic moneyCAD = Money(0, Currency('CAD'));
  dynamic placeCAD = Money(1, Currency('CAD'));
  dynamic test = Money(60, Currency('USD'));
  var displayedCADPrice = 0.00;
  var col = Colors.red;
  String errorVar = 'CAD';
  var response;
  String old = '';
  var testy;

  //
  int usd = 250;
  int cad;
  String usdS;
  String cadS;
  var ic = Icons.sync;
  var textCol = Colors.white;
  var exU = 0.0; // exchange USA
  var exC = 0.0; // exchange Canada


  Icon rw = Icon(
    Icons.signal_wifi_off, //update backup wifi sync
    color: Colors.red,
    size: 40,
  );

  void playSound(){
    final player = AudioCache();
    player.play('but1.wav');
  }

  @override
  void initState() {
    super.initState();
    //final player = AudioCache(); // player.play('button1.wav');
  }
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //XSR // x for notes Screen Ratio
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),// EdgeInsets.all(30.0), // 20
//            width: double.infinity,
//            height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AutoSizeText(
                    'USA GAS PRICE',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 150.0,
                    ),
                    maxLines: 1,
                    maxFontSize: 55,
                  ),
                  AutoSizeText(
                    '$money / gal',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 150.0,
                    ),
                    maxLines: 1,
                    maxFontSize: 55,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RawMaterialButton(
                        enableFeedback: false,
                        onPressed: () {
                          playSound();
                          setState(() {
                            col = Colors.red;
                            displayedCADPrice = 0;
                            if (money > moneyMathMin) {
                              // money is larger than 50
                              if (money < test) {
                                // money less than 10 (60)
                                money = moneyMathMin; // money = 50
                              } else {
                                money =
                                    money - moneyMathBig; // money = money - 10
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: MediaQuery.of(context).size.height/15, // width: 55, // size: MediaQuery.of(context).size.height/25,
                        ),
                        elevation: 20,
                        constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.height/15, // width: 55,
                          height: MediaQuery.of(context).size.height/15, // height: 55,
                        ),
                        shape: CircleBorder(),
                        fillColor: Color(0xff4c4f5e),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        enableFeedback: false,
                        onPressed: () {
                          playSound();
                          setState(() {
                            col = Colors.red;
                            displayedCADPrice = 0;
                            if (money > moneyMathMin) {
                              if (money < moneyMathSmall) {
                                money = moneyMathSmall;
                              } else {
                                money = money - moneyMathSmall;
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.remove,
                          size: MediaQuery.of(context).size.height/15,
                        ),
                        elevation: 20,
                        constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.height/15, // width: 55,
                          height: MediaQuery.of(context).size.height/15, // height: 55,
                        ),
                        shape: CircleBorder(),
                        fillColor: Color(0xff4c4f5e),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        enableFeedback: false,
                        onPressed: () {
                          playSound();
                          setState(() {
                            col = Colors.red;
                            displayedCADPrice = 0;
                            if (money < moneyMathMax) {
                              if (money > moneyMathTS) {
                                money = moneyMathMax;
                              } else {
                                money = money + moneyMathSmall;
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.height/15,
                        ),
                        elevation: 20,
                        constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.height/15, // width: 55,
                          height: MediaQuery.of(context).size.height/15, // height: 55,
                        ),
                        shape: CircleBorder(),
                        fillColor: Color(0xff4c4f5e),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RawMaterialButton(
                        enableFeedback: false,
                        onPressed: () {
                          playSound();
                          setState(() {
                            col = Colors.red;
                            displayedCADPrice = 0;
                            if (money < moneyMathMax) {
                              if (money > moneyMathTB) {
                                money = moneyMathMax;
                              } else {
                                money = money + moneyMathBig;
                              }
                            }
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.height/15,
                        ),
                        elevation: 20,
                        constraints: BoxConstraints.tightFor(
                          width: MediaQuery.of(context).size.height/15, // width: 55,
                          height: MediaQuery.of(context).size.height/15, // height: 55,
                        ),
                        shape: CircleBorder(),
                        fillColor: Color(0xff4c4f5e),
                      ),
                    ],
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0), //EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33), // 0xFF85C9E9
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),// EdgeInsets.all(30.0), // 20
//            width: double.infinity,
//            height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AutoSizeText(
                    'CAN GAS PRICE',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 150.0,
                    ),
                    maxLines: 1,
                    maxFontSize: 55,
                  ),
                  AutoSizeText(
                    '${displayedCADPrice.toStringAsFixed(2)}' + ' CAD' + ' / L',
                    // variable here // use 'money' thing
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 100.0,
                      color: textCol,
                    ),
                    maxLines: 1,
                    maxFontSize: 55,
                  ),
                  AutoSizeText(
                    'EXCH: ${exU.toStringAsFixed(3)} USD/CAD or ${exC.toStringAsFixed(3)} CAD/USD' + ' $old',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 150.0,
                    ),
                    maxLines: 1,
                    maxFontSize: 55,
                  ),
                  Icon(
                    ic, //update backup wifi sync
                    color: col,
                    size: 45,
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
//        SizedBox(
//          height: 15,
//        ),
          Expanded(
            child: RawMaterialButton(
              onPressed: null,
              enableFeedback: false,
              child: Container(
                child: Material(
                  color: Colors.blueAccent,
                  child: InkWell(
                    enableFeedback: false,
                    onTap: () async {
                      playSound();
                      print('pressed');
                      setState(() {
                        col = Colors.red;
                      });
                      try {
                        response = await http
                            .get('https://api.exchangeratesapi.io/latest?base=USD');
                        if (response != null && response.statusCode == 200) {
                          old = '';
                          // change status code possible? // (response.statusCode == 200)
                          setState(() {
                            ic = Icons.sync;
                            textCol = Colors.white;
                          });
                          String data = response.body;
                          var decodedData = jsonDecode(data);
                          var exchange = decodedData['rates']['CAD'];
                          testy = exchange;
                          setState(() {
                            exU = decodedData['rates']['CAD'];
                            exC = 1 / exU;
                          });
                          print(exchange);
                          setState(() {
                            col = Colors.green;
                            moneyCAD = (money * exchange);
                            moneyCAD = (moneyCAD * 0.264172177);
                            int tempCA = moneyCAD.amount;
                            displayedCADPrice = tempCA / 100;
                          });
                        }
                      } catch (_) {
                        setState(() {
                          old = '(previous)';
                        });
                        if (testy == null){
                          old = '(error)';
                          // if it has no previous response to work with: keep it at 0?
                          var exchange = 0.0;
                          setState(() {
                            exU = exchange;
                            exC = 0;
                          });
                          print(exchange);
                          setState(() {
                            col = Colors.red;
                            moneyCAD = (money * exchange);
                            moneyCAD = (moneyCAD * 0.264172177);
                            int tempCA = moneyCAD.amount;
                            displayedCADPrice = tempCA / 100;
                          });
                          print('ERRRRRRRRROR');
                          setState(() {
                            ic = Icons.signal_wifi_off;
                            textCol = Colors.grey;
//                      displayedCADPrice = 0;
                          });
                        }
                        else {
                          print('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
                          // if it has a previous response work with it
                          String data = response.body;
                          var decodedData = jsonDecode(data);
                          var exchange = decodedData['rates']['CAD'];
                          setState(() {
                            exU = exchange;
                            exC = 1 / exU;
                          });
                          print(exchange);
                          setState(() {
                            col = Colors.red;
                            moneyCAD = (money * exchange);
                            moneyCAD = (moneyCAD * 0.264172177);
                            int tempCA = moneyCAD.amount;
                            displayedCADPrice = tempCA / 100;
                          });
                          print('ERRRRRRRRROR');
                          setState(() {
                            ic = Icons.signal_wifi_off;
                            textCol = Colors.grey;
//                      displayedCADPrice = 0;
                          });
                        }
                      }
                    }, // end of onTap,
                    child: Center(
                      child: AutoSizeText(
                        'CALCULATE / RESYNC',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        minFontSize: 25,
                      ),
                    ),
                  ),
                ),
                color: Color(0xFF2C71EB),
//            height: 80,
                width: double.infinity,
                height: MediaQuery.of(context).size.height/8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
