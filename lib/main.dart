import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/ui/home/home_page.dart';
import 'package:vote_app/ui/welcome/welcome_page.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.last;
  runApp(
    MaterialApp(home: HomePage()
        //  WelcomePage(
        //   camera: firstCamera,
        // ),
        // TakePictureScreen(
        //   camera: firstCamera,
        // ),
        ),
  );
}
