import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrator/scannerpage.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController createController = TextEditingController();
  String scanResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
        centerTitle: true,
        title: RichText(
            text: const TextSpan(style: TextStyle(fontSize: 22), children: [
          TextSpan(
              text: "QR",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
          TextSpan(
              text: "ator",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        onPressed: () async {
          await scan();
          if (scanResult == "-1") {
            Fluttertoast.showToast(
                msg: "You Cancelled",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.amber,
                textColor: Colors.black,
                fontSize: 10.0);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => scannerpage(scanResult),
              ),
            );
          }
        },
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: createController.text.isEmpty
                    ? RichText(
                        text: const TextSpan(style: TextStyle(), children: [
                        TextSpan(
                            text: "Enter Data to",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 60)),
                        TextSpan(
                            text: " Encode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                fontSize: 80)),
                      ]))
                    : Card(
                        color: Colors.white,
                        elevation: 5.0,
                        shadowColor: Colors.limeAccent,
                        child: BarcodeWidget(
                          margin: const EdgeInsets.all(20.0),
                          height: 300,
                          width: 500,
                          data: createController.text,
                          barcode: Barcode.qrCode(),
                        ),
                      ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: createController,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: "data",
                    hintStyle: TextStyle(color: Colors.amberAccent),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30)),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 22),
                      children: [
                        TextSpan(
                            text: "G E N E",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        TextSpan(
                            text: " R A T E",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //scan function

  Future scan() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#FFBF00",
        "CANCEL",
        true,
        ScanMode.QR,
      );
    } on PlatformException {
      scanResult = "Failed to get platform version";
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;
    });
  }

  // trying to write a function to save barcode to gallary
  // failing miserably by the way
  //feel free to hope in here and do that for yourself
  //adios fellow madman lol

  // Future save() async {
  //   final png = BarcodeWidget(
  //     margin: const EdgeInsets.all(20.0),
  //     height: 300,
  //     width: 500,
  //     data: createController.text,
  //     barcode: Barcode.qrCode(),
  //   );

  //   final savetogallary = await png.toPngBytes();
  //   final time = DateTime.now().toString();
  //   final name = "signaturer-$time";
  //   final result = await savetogallary.saveImage(png, name: name);
  // }
}
