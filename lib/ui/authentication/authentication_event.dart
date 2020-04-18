part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent{}
class Login extends AuthenticationEvent{
  final String token;

  Login({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn(token: $token)';
}
class LoggedIn extends AuthenticationEvent {
}
class LoggedOut extends AuthenticationEvent{}