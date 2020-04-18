import 'package:flutter/cupertino.dart';

class UserRepository{
  Future<String> authenticate({
    @required String username,
    @required String password
  }) async{
    //TODO: backend and logic will be writen here.
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async{
    //TODO: backend and logic will be writen here.
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async{
    //TODO: backend and logic will be writen here.
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async{
    //TODO: backend and logic will be writen here.
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}