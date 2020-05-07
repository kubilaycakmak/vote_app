import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'getdata_event.dart';
part 'getdata_state.dart';

class GetdataBloc extends Bloc<GetdataEvent, GetdataState> {
  @override
  GetdataState get initialState => DataIsNotList();

  @override
  Stream<GetdataState> mapEventToState(
    GetdataEvent event,
  ) async* {
    if (event is FetchData) {
      yield DataIsLoading();
      try {
        //TODO: use repository and get data to model class
        yield DataIsLoaded();
      } catch (_) {
        yield DataIsNotLoaded();
      }
    }
  }
}
