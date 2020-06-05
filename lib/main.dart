import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/ui/login/verify_page.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.last;
  runApp(MaterialApp(
      home: TakePictureScreen(
    camera: firstCamera,
  )));
}
