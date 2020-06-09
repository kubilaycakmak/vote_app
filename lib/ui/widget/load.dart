import 'package:flutter/material.dart';
import 'package:vote_app/ui/style/text/style.dart';

void onLoad({
  @required BuildContext context,
  @required String text,
  Function function,
}) {
  showDialog(
    context: context,
    barrierDismissible: text == 'Warning' ?? true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black38,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Color.fromRGBO(0, 40, 77, 1), width: 2)),
        title: Column(
          children: <Widget>[
            text == "Warning"
                ? Container()
                : CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            text == "Warning"
                ? Container(
                    color: Colors.blue,
                    child: FlatButton(
                        child: Text('Submit', style: h1bold),
                        onPressed: function),
                  )
                : Container()
          ],
        ),
      );
    },
  );
}
