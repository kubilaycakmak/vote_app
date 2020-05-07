part of 'getdata_bloc.dart';

abstract class GetdataState extends Equatable {
  const GetdataState();

  @override
  List<Object> get props => throw [];
}

class DataIsNotList extends GetdataState {}

class DataIsLoading extends GetdataState {}

class DataIsLoaded extends GetdataState {
 //TODO: data handle and model class
}
class DataIsNotLoaded extends GetdataState{}
