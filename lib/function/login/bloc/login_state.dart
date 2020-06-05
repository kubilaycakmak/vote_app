part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({@required this.token});
  @override
  // TODO: implement props
  List<Object> get props => [token];
}

class LoginUnsuccess extends LoginState {
  final String error;

  LoginUnsuccess({@required this.error});

  List<Object> get props => [error];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
