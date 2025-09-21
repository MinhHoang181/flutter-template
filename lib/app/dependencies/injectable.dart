import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:template/app/dependencies/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

extension GetItExtension on GetIt {
  T? getOrNull<T extends Object>({String? instanceName}) {
    if (isRegistered<T>(instanceName: instanceName)) {
      return get<T>(instanceName: instanceName);
    }
    return null;
  }
}
