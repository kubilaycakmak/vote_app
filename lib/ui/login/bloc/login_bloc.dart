import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vote_app/data/repository/user_repository.dart';
import 'package:vote_app/ui/authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    this.authenticationBloc})
   : 
     assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed){
      yield LoginLoading();
      try{
        final token = await userRepository.authenticate(username: event.username, password: event.password);
        authenticationBloc.add(Login(token: token));
        yield LoginInitial();
      }catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
    if(event is RequestButtonPressed){
      //TODO: login here..
    }
  }
}
