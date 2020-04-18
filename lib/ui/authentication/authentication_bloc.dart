import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vote_app/data/repository/user_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository}) :assert(userRepository != null);
  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AppStarted){
      
    }
    if(event is LoggedIn){
      yield AuthenticationLoading();
      //TODO: add verify logic here
      yield AuthenticationAuthenticated();
      
    }
    if(event is Login){
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      //TODO: call face recog page
    }
    if(event is LoggedOut){
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
