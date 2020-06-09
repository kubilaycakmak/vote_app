import 'dart:async';

import 'package:path/path.dart' show join;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vote_app/data/repository/user_repository.dart';
import 'package:vote_app/data/verify/verify_model.dart';
import 'package:vote_app/ui/home/home_page.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/widget/load.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  Timer t;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Future<Verify> futureVerify;
  String floatButtonTitle = "Verify";

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.low,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Verify>(
        future: futureVerify,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.name != "Unknown") {
              return Container(
                decoration: BoxDecoration(gradient: backgroundGradient),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mr." + snapshot.data.name,
                        style: h0,
                      ),
                      Text(
                        "Welcome",
                        style: h0,
                      ),
                      FlatButton(
                        child: Text(
                          'Continue',
                          style: h1,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          }
          if (!snapshot.hasData) {
            return FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    decoration: BoxDecoration(gradient: backgroundGradient),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 150),
                      child: CameraPreview(_controller),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }
          return Container(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Container(
        height: 70,
        child: FloatingActionButton.extended(
          label: Text(floatButtonTitle),
          onPressed: () async {
            floatButtonTitle == "Back"
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                              camera: widget.camera,
                            )))
                : await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path);
            print(path);
            onLoad(context: context, text: 'Verifying..');
            futureVerify = verify(filename: path);
            t = new Timer(
              Duration(milliseconds: 250),
              () async {
                t.cancel();
                setState(
                  () {
                    floatButtonTitle = "Back";
                  },
                );
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
