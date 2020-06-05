import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_app/function/login/bloc/login_bloc.dart';
import 'package:vote_app/ui/login/verify_page.dart';
import 'package:vote_app/ui/style/color/colors.dart';
import 'package:vote_app/ui/style/text/style.dart';
import 'package:vote_app/ui/welcome/welcome_page.dart';

class LoginPage extends StatefulWidget {
  final CameraDescription camera;

  const LoginPage({Key key, this.camera}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _loginBloc,
      child: Scaffold(
        body: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoginSuccess) {
              _onWidgetDidBuild(
                () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('success'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  return TakePictureScreen(
                    camera: widget.camera,
                  );
                },
              );
              // return VerifyPage();
            }
            if (state is LoginFailure) {
              _onWidgetDidBuild(
                () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            }
            return _buildLogin(context);
          },
        ),
      ),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoadingButtonPressed() {
    print(_emailController.text);
    _loginBloc.dispatch(
        LoginButtonPressed(_emailController.text, _passwordController.text));
  }

  Widget _buildLogin(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
        ),
        ListView(
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                    heroTag: 'login',
                    onPressed: () {
                      _onLoadingButtonPressed();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => VerifyPage()));
                    },
                    label: Text('Login')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Container(
                width: 999,
                child: FloatingActionButton.extended(
                    heroTag: 'info',
                    onPressed: () {},
                    label: Text('Request Information')),
              ),
            ),
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}
