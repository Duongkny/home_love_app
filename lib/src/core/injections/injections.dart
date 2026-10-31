import 'package:get_it/get_it.dart';
import 'package:homelove/src/core/injections/injections.config.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}