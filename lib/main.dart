import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vote_app/ui/home/home_page.dart';
import 'package:vote_app/ui/login/login_page.dart';
import 'package:vote_app/ui/welcome/welcome_page.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.last;
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            // LoginPage()
            HomePage()
        //     WelcomePage(
        //   camera: firstCamera,
        // ),
        // TakePictureScreen(
        //   camera: firstCamera,
        // ),
        ),
  );
}
