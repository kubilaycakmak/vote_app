import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:vote_app/ui/welcome/bloc/getdata_bloc.dart';

void initKiwi() {
  kiwi.Container()
    ..registerInstance(http.Client())
    ..registerFactory((container) =>
        GetdataBloc()); //container.resolve() after data implementation
}
