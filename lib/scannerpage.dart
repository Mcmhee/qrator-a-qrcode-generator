import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class scannerpage extends StatelessWidget {
  String scanResult;
  scannerpage(this.scanResult, {Key? key}) : super(key: key);

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
            text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                ),
                children: [
              TextSpan(
                  text: "QR",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
              TextSpan(
                  text: "ator",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  )),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FlutterClipboard.copy(scanResult);

          Fluttertoast.showToast(
              msg: "Copied to Clipboard",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.amber,
              textColor: Colors.black,
              fontSize: 16.0);
        },
        child: const Icon(
          Icons.file_copy_outlined,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              "Scan Result",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 60.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              scanResult,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
