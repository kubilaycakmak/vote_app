import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/data/repository/user_repository.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token =
            await signin(email: event.email, password: event.password);
        print(token);
        if (token == 'unsuccessful' || token == '') {
          yield LoginFailure(error: token);
        } else {
          yield LoginSuccess(token: token);
        }
      } catch (e) {
        // yield LoginFailure(error: e.toString());
        // print(e);
      }
    }
  }
}
