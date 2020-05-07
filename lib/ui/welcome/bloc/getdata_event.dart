part of 'getdata_bloc.dart';

abstract class GetdataEvent extends Equatable {
  const GetdataEvent();
  @override
  List<Object> get props => throw [];
}

class FetchData extends GetdataEvent{
  //TODO: parametres and fetching methods here
}
