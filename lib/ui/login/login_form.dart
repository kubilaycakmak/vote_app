import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vote_app/ui/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // _onLoginButtonPressed(){
    //   BlocProvider.of<LoginBloc>(context).add(
    //     LoginButtonPressed(
    //       username: _usernameController.text,
    //       password: _passwordController.text
    //     ),
    //   );
    // }
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        if(state is LoginFailure){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            )
          );
        }
      },
      child: BlocBuilder(
        builder: (context, state){
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'National ID'),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  controller: _passwordController,
                  obscureText: true,
                ),
                FloatingActionButton.extended(
                  onPressed: null,
                  label: Text('Login')
                ),
                Container(
                  child: state is LoginLoading
                  ? CircularProgressIndicator()
                  : null,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}