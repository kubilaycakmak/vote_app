import 'package:flutter/material.dart';

void onLoad(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black38,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromRGBO(0, 40, 77, 1), width: 2)),
        title: Column(
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    },
  );
}
