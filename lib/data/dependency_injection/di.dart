import 'package:injectable/injectable.dart';
import 'package:ahamove/core/injection/injector_container.dart';

import 'di.config.dart';

String token = "";
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
// configureDependencies() => injector.init();

Future<void> configureDependencies({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async =>
    init(
      injector,
      environment: environment,
      environmentFilter: environmentFilter,
    );
