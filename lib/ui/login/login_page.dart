import 'package:flutter/material.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/welcome/welcome_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLogin(context),
    );
  }

  Widget buildLogin(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text(
                'Login',
                style: h1,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              color: Colors.white30,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email or National ID :',
                  style: h4,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Ex: asd@example.com',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  obscureText: false,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password:',
                  style: h4,
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Ex: 123213124',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  obscureText: false,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                width: 999,
                child: FloatingActionButton.extended(
                    heroTag: 'login', onPressed: null, label: Text('Login')),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                width: 999,
                child: FloatingActionButton.extended(
                    heroTag: 'info',
                    onPressed: null,
                    label: Text('Request Information')),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                width: 999,
                child: FloatingActionButton.extended(
                    heroTag: 'back',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WelcomePage()));
                    },
                    label: Text('Back')),
              )),
        ],
      ),
    );
  }
}
