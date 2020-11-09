import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'package:qr_scanner/dataCards.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var back_end_url = "http://192.168.1.114:8000/";

  List<String> listItems = ['ليبيانا', 'مادار'];
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedItem;
  ScanResult qrResult;
  String barcodeResult;
  final qrController = TextEditingController();
  final barcodeController = TextEditingController();
  final cardValueController = TextEditingController();

  buildCropDownValues(CardsProvides listvalues) {
    List<DropdownMenuItem<String>> values = List();
    for (Providers value in listvalues.providers) {
      values.add(DropdownMenuItem(child: Text(value.name), value: value.name));
    }
    return values;
  }

  Future<void> getCards() async {
    var url = back_end_url + "Get_Providers";
    var result =
        await http.get(url, headers: {"Content-Type": "application/json"});
    CardsProvides values = CardsProvides.fromJson(json.decode(result.body));
    setState(() {
      _dropdownMenuItems = buildCropDownValues(values);
    });
  }

  void createCard() async {
    print("runing function");
    if (_selectedItem != "" &&
        qrController.text != "" &&
        barcodeController.text != "" &&
        cardValueController.text != "") {
      final http.Response response = await http.post(
        back_end_url + 'Crate_Card',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'cardType': _selectedItem,
          'cardValue': cardValueController.text,
          'qrValue': qrController.text,
          'barcodeValue': barcodeController.text
        }),
      );
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print("this output" + response.body);
        // return response.statusCode;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print("this output" + response.body);
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("First Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: _selectedItem,
                  items: _dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedItem = value;
                    });
                  },
                  underline: SizedBox(),
                  isDense: true,
                  hint: Text(
                    ' نوع الكرت ',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) async {
                  cardValueController.text = value;
                  await createCard();
                },
                controller: cardValueController,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "قيمة الكرت",
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 50,
                  //width: MediaQuery.of(context).size.width /2,
                  child: Stack(
                    children: <Widget>[
                      TextField(
                        onChanged: (value) async {
                          qrController.text = value;
                          await createCard();
                        },
                        controller: qrController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "qr reader",
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            child: IconButton(
                              icon: Icon(
                                Icons.qr_code_scanner_sharp,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                qrResult = await BarcodeScanner.scan();
                                setState(() {
                                  qrController.text = qrResult.rawContent;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 50,
                  //width: MediaQuery.of(context).size.width /2,
                  child: Stack(
                    children: <Widget>[
                      TextField(
                        onChanged: (value) async {
                          await createCard();
                        },
                        controller: barcodeController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "barcode reader",
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            child: IconButton(
                              icon: Icon(
                                Icons.qr_code_scanner_sharp,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                qrResult = await BarcodeScanner.scan();
                                setState(() {
                                  barcodeController.text = qrResult.rawContent;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
