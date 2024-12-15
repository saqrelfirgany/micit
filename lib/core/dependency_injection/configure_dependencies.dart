import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:micit/core/dependency_injection/configure_dependencies.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future configureDependencies() async {
  return serviceLocator.init();
}
