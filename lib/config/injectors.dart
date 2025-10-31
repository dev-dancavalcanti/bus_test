import 'package:auto_injector/auto_injector.dart';
import 'package:bus_teste/data/repositories/user/user_repository.dart';
import 'package:bus_teste/data/services/client_http.dart';
import 'package:bus_teste/data/services/local_storage.dart';
import 'package:bus_teste/data/services/user/user_client_http.dart';
import 'package:bus_teste/data/services/user/user_local_storage.dart';
import 'package:bus_teste/viewmodels/ticker_viewmodel.dart';
import 'package:bus_teste/viewmodels/user_viewmodel.dart';
import 'package:dio/dio.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addSingleton(UserRepository.new);
  injector.addInstance(Dio());
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(UserClientHttp.new);
  injector.addSingleton(UserLocalStorage.new);
  injector.addSingleton(UserViewModel.new);
  injector.addSingleton(TickerViewModel.new);
  injector.commit();
}
