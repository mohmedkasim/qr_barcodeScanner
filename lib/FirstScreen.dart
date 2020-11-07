import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> listItems;
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedItem;
  ScanResult qrResult;
  String barcodeResult;
  final qrController = TextEditingController();
  final barcodeController = TextEditingController();
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
